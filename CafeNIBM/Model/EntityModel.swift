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

struct Order {
    var orderID: String
    var cust_email: String
    var cust_name: String
    var date: Double
    var status_code: Int
    var orderItems: [OrderItem] = []
}

struct OrderItem {
    var item_name: String
    var price: Double
}
