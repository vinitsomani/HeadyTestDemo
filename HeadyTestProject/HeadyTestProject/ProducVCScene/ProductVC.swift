//
//  ProductVC.swift
//  HeadyTestProject
//
//  Created by Vinit Somani on 4/30/18.
//  Copyright © 2018 Vinit Somani. All rights reserved.
//

import UIKit

class ProductVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var taxLabel: UILabel!
    fileprivate let cellIdentifier = "CollectionCell"
    
    var products: Products!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.titleLabel.text = self.products.name
            self.taxLabel.text = (self.products.tax?.name)! + ": \(self.products.tax?.value! ?? 0.0)"
            self.collectionView.reloadData()
        }
    }
    
    func setupCollectionView(){
        self.collectionView.register(UINib.init(nibName: "ProductCollectionCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self as UICollectionViewDataSource
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ProductVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let product = products.variants
        {
            return product.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ProductCollectionCell
        cell?.setCellProductDataFor(variant: products.variants![indexPath.row])
        return cell!
    }
    
}


extension ProductVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: self.collectionView.bounds.width , height: self.collectionView.bounds.height);
    }
}

