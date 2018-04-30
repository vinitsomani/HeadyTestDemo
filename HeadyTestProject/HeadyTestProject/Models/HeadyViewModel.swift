//
//  HeadyViewModel.swift
//  HeadyTestProject
//
//  Created by Vinit Somani on 4/28/18.
//  Copyright © 2018 Vinit Somani. All rights reserved.
//
import Foundation

struct HeadyViewModel: Codable {
    let categories : [Categories]?
    let rankings : [Rankings]?
}

struct Categories : Codable {
    var id : Int?
    let name : String?
    let products : [Products]?
    let child_categories : [Int]
}

struct Rankings : Codable {
    let ranking : String?
    let products : [ProductsRankings]?
}

struct ProductsRankings : Codable {
    let id : Int?
    let view_count : Int?
}

struct Products : Codable{
    var id : Int
    var name: String?
    var date_added: String?
    var variants: [Variant]?
    var tax: Tax?
}

struct Variant : Codable  {
    var id: Int?
    var color: String?
    var size: Int?
    var price: Int?
}

struct Tax : Codable {
    var name : String?
    var value : Float?
}


class HeadyModelFilterClass{
    var headyViewModel: HeadyViewModel!
    static let sharedFilter = HeadyModelFilterClass()
    fileprivate var parentCategoriesIds = [Int]()
    func initialiseHeadyModelFilterClass(headyViewModel: HeadyViewModel){
        self.headyViewModel = headyViewModel
    }
    
    func getHeadyModelParentCategory()-> [Categories] {
        
        var topParentCategories = [Categories]()
        
        if let categories = self.headyViewModel.categories
        {
            var intArr1 = [Int]()
            for item in categories{
                intArr1.append(item.id!)
            }
            let parentCategories = categories.filter({$0.child_categories.count > 0}) as [Categories]
            var intArr = [Int]()
            for item in parentCategories{
                intArr = intArr + item.child_categories
            }
            parentCategoriesIds = Array(Set(intArr).symmetricDifference(Set(intArr1)))
            
            
            for (index,_) in parentCategoriesIds.enumerated(){
                topParentCategories = topParentCategories + parentCategories.filter({$0.id == parentCategoriesIds[index]})
            }
        }
        return topParentCategories
    }
    
    func getHeadyCategoryOfID(categoryId : Int) -> Categories?{
        let category = headyViewModel.categories?.filter({$0.id == categoryId}).first
        return category!
    }
}
