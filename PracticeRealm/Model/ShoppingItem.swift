//
//  ShoppingItem.swift
//  PracticeRealm
//
//  Created by YJ on 7/19/24.
//

import Foundation

struct ShoppingList {
    let list: [ShoppingItem]
}

struct ShoppingItem {
    let name: String
    let price: Int
    let remainingStock: Int
}
