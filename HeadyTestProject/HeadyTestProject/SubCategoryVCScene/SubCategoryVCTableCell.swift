//
//  CategoryVCTableCell.swift
//  HeadyTestProject
//
//  Created by Vinit Somani on 4/29/18.
//  Copyright © 2018 Vinit Somani. All rights reserved.
//

import UIKit

protocol SubCategoryVCTableCellDelegate: NSObjectProtocol{
func subCategoryCellSelectedID(product: Products)
}

class SubCategoryVCTableCell: UITableViewCell {

    @IBOutlet weak var collectinView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    fileprivate var products: [Products]!
    
    fileprivate let cellIdentifier = "CollectionCell"
    weak var delegate: SubCategoryVCTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCollectionView()
    }

    func setCellCategoryData(categoryId: Int){
        
        if let model = HeadyModelFilterClass.sharedFilter.getHeadyCategoryOfID(categoryId: categoryId){
            titleLabel.text = model.name
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            
            if let productsArray = model.products{
                let sortedTimeArray = productsArray.sorted(by: { dateFormatter.date(from: $0.date_added!)?.compare(dateFormatter.date(from: $1.date_added!)!) == .orderedDescending })
                products = sortedTimeArray
            }
            
        }
        DispatchQueue.main.async {
            self.collectinView.reloadData()
        }
    }
    
    func setupCollectionView(){
        self.collectinView.register(UINib.init(nibName: "SubCategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectinView.dataSource = self
        DispatchQueue.main.async {
            self.collectinView.reloadData()
        }
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension SubCategoryVCTableCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let products = products
        {
            return products.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? SubCategoryCollectionCell
        cell?.setCellCategoryDataFor(product: products[indexPath.row])
        return cell!
    }
    
}


extension SubCategoryVCTableCell: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.subCategoryCellSelectedID(product: products[indexPath.row])
    }
}


extension SubCategoryVCTableCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 180 , height: 234);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
