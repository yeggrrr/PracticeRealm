//
//  CartRepository.swift
//  PracticeRealm
//
//  Created by YJ on 7/21/24.
//

import Foundation
import RealmSwift

class CartRepository: CartRepositoryType {
    static let shared = CartRepository()
    
    private let realm = try! Realm()
    
    private init() { }
    
    var count: Int {
        return fetch().count
    }
    
    func findFilePath() {
        print(realm.configuration.fileURL ?? "-")
    }
    
    func fetch() -> [CartItemRealm] {
        return Array(realm.objects(CartItemRealm.self))
    }
    
    func add(item: CartItemRealm) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("Failed to add: \(error)")
        }
    }
    
    func update(item: CartItemRealm) {
        do {
            try realm.write {
                realm.add(item, update: .modified)
            }
        } catch {
            print("Failed to add: \(error)")
        }
    }
    
    func delete(item: CartItemRealm) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("Failed to add: \(error)")
        }
    }
}

protocol CartRepositoryType {
    var count: Int { get }
    func fetch() -> [CartItemRealm]
    func add(item: CartItemRealm)
    func update(item: CartItemRealm)
    func delete(item: CartItemRealm)
}
