//
//  CartItemRealm.swift
//  PracticeRealm
//
//  Created by YJ on 7/21/24.
//

import Foundation
import RealmSwift

class CartItemRealm: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var price: Int
    @Persisted var count: Int
    
    convenience init(id: ObjectId, name: String, price: Int, count: Int) {
        self.init()
        self.id = id
        self.name = name
        self.price = price
        self.count = count
    }
    
    convenience init(name: String, price: Int, count: Int) {
        self.init()
        self.name = name
        self.price = price
        self.count = count
    }
}
