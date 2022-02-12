//
//  CategoryData.swift
//  MealApp
//
//  Created by John Santiago on 2/12/22.
//

import Foundation

struct CategoryData: Codable {
    let categories : [CategoryFeatures]
//    let idCategory : String?
//    let strCategory : String?
//    let thumbCategory : String?
//    let descriptionCategory : String?
    
    
    
}


struct CategoryFeatures: Codable {
    let idCategory : String?
    let strCategory : String?
    let strCategoryThumb : String?
    let strCategoryDescription : String?
}
