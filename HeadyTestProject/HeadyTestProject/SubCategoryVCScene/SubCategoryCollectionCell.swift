//
//  CategoryCollectionCell.swift
//  HeadyTestProject
//
//  Created by Vinit Somani on 4/29/18.
//  Copyright © 2018 Vinit Somani. All rights reserved.
//

import UIKit

class SubCategoryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var ccategiryTitle: UILabel!
    var product: Products!
    
    @IBOutlet weak var arrivedDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellCategoryDataFor(product: Products) {
        self.product = product
        ccategiryTitle.text = product.name
        arrivedDate.text = product.date_added
    }
}
