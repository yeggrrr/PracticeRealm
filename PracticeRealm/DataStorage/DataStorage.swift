//
//  DataStorage.swift
//  PracticeRealm
//
//  Created by YJ on 7/19/24.
//

import Foundation

class DataStorage {
    static let shared = DataStorage()
    
    private init() { }
    
    var shoppingList: [ShoppingList] = []
    var shoppingItem: [ShoppingItem] = []
}
