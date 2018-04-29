//
//  CategoryVC.swift
//  HeadyTestProject
//
//  Created by Vinit Somani on 4/28/18.
//  Copyright © 2018 Vinit Somani. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {

    @IBOutlet weak var categoryTable: UITableView!
    fileprivate var headyViewModel: HeadyViewModel!
    fileprivate var categories: [Categories]!
    fileprivate var rankings: [Rankings]!
    let cellIdentifier = "tabelCell"
    fileprivate var parentCategories = [Categories]()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCellNib()
        self.callHeadyData()
    }
    
    func callHeadyData(){
        let url = URL(string: "https://stark-spire-93433.herokuapp.com/json")
        URLSession.shared.dataTask(with: url!) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let modelData = try decoder.decode(HeadyViewModel.self, from: data)
                
                HeadyModelFilterClass.sharedFilter.initialiseHeadyModelFilterClass(headyViewModel: modelData)
                self.parentCategories = HeadyModelFilterClass.sharedFilter.getHeadyModelParentCategory()
                DispatchQueue.main.async {
                    self.categoryTable.reloadData()
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
    
    func registerCellNib(){
        let nib = UINib(nibName: "CategoryVCTableCell", bundle: nil)
        categoryTable.register(nib, forCellReuseIdentifier: cellIdentifier)
        self.categoryTable.dataSource = self as UITableViewDataSource
        self.categoryTable.rowHeight = 280
        DispatchQueue.main.async {
            self.categoryTable.reloadData()
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension CategoryVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.categoryTable.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CategoryVCTableCell
        cell.selectionStyle = .none;
        cell.setCellCategoryData(categories: parentCategories[indexPath.row])
        
        return cell
    }
}


