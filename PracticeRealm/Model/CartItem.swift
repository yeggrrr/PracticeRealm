//
//  CartItem.swift
//  PracticeRealm
//
//  Created by YJ on 7/19/24.
//

import Foundation

struct CartItem: Equatable {
    let name: String
    let price: Int
    var count: Int
    
    static func ==(lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price
    }
}
