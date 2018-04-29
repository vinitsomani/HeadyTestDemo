//
//  CategoryVCTableCell.swift
//  HeadyTestProject
//
//  Created by Vinit Somani on 4/29/18.
//  Copyright © 2018 Vinit Somani. All rights reserved.
//

import UIKit

class CategoryVCTableCell: UITableViewCell {

    @IBOutlet weak var collectinView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    fileprivate var categories: Categories!
    
    fileprivate let cellIdentifier = "CollectionCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
    }

    func setCellCategoryData(categories: Categories){
        self.categories = categories
        titleLabel.text = self.categories.name
        DispatchQueue.main.async {
            self.collectinView.reloadData()
        }
    }
    
    func setupCollectionView(){
        self.collectinView.register(UINib.init(nibName: "CategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectinView.dataSource = self
        DispatchQueue.main.async {
            self.collectinView.reloadData()
        }
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension CategoryVCTableCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let model = categories?.child_categories
        {
            return model.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CategoryCollectionCell
        cell?.setCellCategoryDataFor(categoryId: (categories?.child_categories[indexPath.row])!)
        return cell!
    }
    
}


extension CategoryVCTableCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


extension CategoryVCTableCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 180 , height: 234);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
