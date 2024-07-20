//
//  ShoppingItemRealm.swift
//  PracticeRealm
//
//  Created by YJ on 7/20/24.
//

import Foundation
import RealmSwift

class ShoppingItemRealm: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var price: Int
    @Persisted var remainingStock: Int
    
    convenience init(id: ObjectId, name: String, price: Int, remainingStock: Int) {
        self.init()
        self.id = id
        self.name = name
        self.price = price
        self.remainingStock = remainingStock
    }
    
    convenience init(name: String, price: Int, remainingStock: Int) {
        self.init()
        self.name = name
        self.price = price
        self.remainingStock = remainingStock
    }
}
