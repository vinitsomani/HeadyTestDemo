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
    let cellIdentifier = "tabelCell"
    
    var category: Categories!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCellNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.titleLabel.text = category.name
        DispatchQueue.main.async {
            self.subCategoryTable.reloadData()
        }
    }
    
    func registerCellNib(){
        let nib = UINib(nibName: "SubCategoryVCTableCell", bundle: nil)
        subCategoryTable.register(nib, forCellReuseIdentifier: cellIdentifier)
        subCategoryTable.dataSource = self as UITableViewDataSource
        subCategoryTable.rowHeight = 280
        DispatchQueue.main.async {
            self.subCategoryTable.reloadData()
        }
    }
    
    func setCategory(category: Categories){
        self.category = category
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
        let cell = self.subCategoryTable.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SubCategoryVCTableCell
        cell.delegate = self as SubCategoryVCTableCellDelegate
        cell.selectionStyle = .none;
        cell.setCellCategoryData(categoryId: category.child_categories[indexPath.row])
        return cell
    }
}

extension SubCategoryVC: SubCategoryVCTableCellDelegate{
    func subCategoryCellSelectedID(product: Products) {
        let controller = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        controller.products = product
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


