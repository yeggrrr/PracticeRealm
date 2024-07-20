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
    
    var cartList: [CartItem] = []
    
    private func load(fileName: String) -> Data? {
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            return nil
        }
    }
    
    func initData() {
        guard let data = load(fileName: "ShoppingData") else { return }
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ShoppingList.self, from: data)
           
            result.list.forEach {
                let shoppingItemRealm = ShoppingItemRealm(
                    name: $0.name,
                    price: $0.price,
                    remainingStock: $0.remainingStock)
                ShoppingRepository.shared.add(item: shoppingItemRealm)
            }
        } catch {
            print("Failed to init data")
        }
    }
}
