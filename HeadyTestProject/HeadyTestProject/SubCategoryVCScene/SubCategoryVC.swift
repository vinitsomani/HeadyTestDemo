//
//  SubCategoryVC.swift
//  HeadyTestProject
//
//  Created by Vinit Somani on 4/29/18.
//  Copyright © 2018 Vinit Somani. All rights reserved.
//

import UIKit

class SubCategoryVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subCategoryTable: UITableView!
    
    var category: Categories!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subCategoryTable.delegate = self as UITableViewDelegate
        subCategoryTable.dataSource = self as UITableViewDataSource
        subCategoryTable.rowHeight = 54.0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension SubCategoryVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let category = category{
         return category.child_categories.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        let subCategory = HeadyModelFilterClass.sharedFilter.getHeadyCategoryOfID(categoryId: category.child_categories[indexPath.row])
        cell.textLabel!.text = subCategory?.name
        return cell
    }
}

extension SubCategoryVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}



