//
//  CategoryCollectionCell.swift
//  HeadyTestProject
//
//  Created by Vinit Somani on 4/29/18.
//  Copyright © 2018 Vinit Somani. All rights reserved.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {

    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    
    
    var variant: Variant!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    func setCellProductDataFor(variant: Variant) {
        self.variant = variant
        if let variantSize = variant.size{
            size.text = "Size: " + "\(variantSize)"
        }
        else{
            size.text = ""
        }

        color.text = "Color: " + "\(variant.color!)"
        price.text = "Price: " + "\(variant.price!)"
    }
}
