//
//  CategoryCollectionCell.swift
//  HeadyTestProject
//
//  Created by Vinit Somani on 4/29/18.
//  Copyright © 2018 Vinit Somani. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var ccategiryTitle: UILabel!
    var categoryData: Categories!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCellCategoryDataFor(categoryId: Int) {
        if let category = HeadyModelFilterClass.sharedFilter.getHeadyCategoryOfID(categoryId: categoryId){
            self.categoryData = category
            ccategiryTitle.text = self.categoryData.name
        }
    }

}
