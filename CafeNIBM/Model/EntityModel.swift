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
