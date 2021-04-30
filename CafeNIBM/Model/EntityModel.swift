//
//  EntityModel.swift
//  CafeNIBM
//
//  Created by Nuwan Mudalige on 2021-04-25.
//

import Foundation

struct User {
    var username: String
    var userEmail: String
    var userPassword: String
    var userPhone: String
}

struct FoodItem {
    var _id: String
    var foodName: String
    var foodDes: String
    var foodPrice: Double
    var discount: Int
    var image: String
    var category: String
}

struct Category {
    var categoryID: String
    var catergoryName: String
}

struct Food {
    var foodItemID: String
    var foodName: String
    var foodDescription: String
    var foodPrice: Double
    var discount: Int
    var foodImg: String
    var foodCategory: String
    var isActive: Bool
}
