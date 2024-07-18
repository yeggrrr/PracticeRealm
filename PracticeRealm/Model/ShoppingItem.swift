//
//  ShoppingItem.swift
//  PracticeRealm
//
//  Created by YJ on 7/19/24.
//

import Foundation

struct ShoppingList: Decodable {
    let list: [ShoppingItem]
}

struct ShoppingItem: Decodable {
    let name: String
    let price: Int
    let remainingStock: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case price = "price"
        case remainingStock = "remaining_stock"
    }
}
