//
//  CategoryVC.swift
//  HeadyTestProject
//
//  Created by Vinit Somani on 4/28/18.
//  Copyright © 2018 Vinit Somani. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {

    @IBOutlet weak var categorTable: UITableView!
    fileprivate var headyViewModel: HeadyViewModel!
    fileprivate var categories: [Categories]!
    fileprivate var rankings: [Rankings]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categorTable.dataSource = (self as UITableViewDataSource)
        categorTable.delegate = (self as UITableViewDelegate)
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
                self.categories = modelData.categories
                self.rankings = modelData.rankings
                self.filterHeadyModelCategory()
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }

    
    func filterHeadyModelCategory() {
        if let categories = categories
        {
            var intArr1 = [Int]()
            for item in categories{
                intArr1.append(item.id!)
            }
            let parentCategories = categories.filter({$0.child_categories.count > 0})
            var intArr = [Int]()
            for item in parentCategories{
                intArr = intArr + item.child_categories
            }
            let unicArr = Set(intArr).symmetricDifference(Set(intArr1))
            print(unicArr)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension CategoryVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")
        cell?.textLabel?.text = ""
        return cell!
    }
    
    
}

extension CategoryVC: UITableViewDelegate{
    
}



