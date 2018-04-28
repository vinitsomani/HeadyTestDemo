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
    let id : Int?
    let name : String?
    let products : [Products]?
    let child_categories : [Int]
}

struct Rankings : Codable {
    let ranking : String?
    let products : [Products]?
}

struct Products : Codable {
    let id : Int?
    let view_count : Int?
}



