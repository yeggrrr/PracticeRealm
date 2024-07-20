//
//  ShoppingRepository.swift
//  PracticeRealm
//
//  Created by YJ on 7/20/24.
//

import Foundation
import RealmSwift

class ShoppingRepository: ShoppingRepositoryType {
    static let shared = ShoppingRepository()
    
    private let realm = try! Realm()
    
    private init() { }
    var count: Int {
        return fetch().count
    }
    
    func findFilePath() {
        print(realm.configuration.fileURL ?? "-")
    }
    
    func fetch() -> [ShoppingItemRealm] {
        return Array(realm.objects(ShoppingItemRealm.self))
    }
    
    func add(item: ShoppingItemRealm) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("Failed to add: \(error)")
        }
    }
    
    func update(item: ShoppingItemRealm) {
        do {
            try realm.write {
                realm.add(item, update: .modified)
            }
        } catch {
            print("Failed to update: \(error)")
        }
    }
    
    func delete(item: ShoppingItemRealm) {
        do {
            try realm.write {
                realm.delete(item)
            }
        } catch {
            print("Failed to delete: \(error)")
        }
    }
}

protocol ShoppingRepositoryType {
    var count: Int { get }
    func fetch() -> [ShoppingItemRealm]
    func add(item: ShoppingItemRealm)
    func update(item: ShoppingItemRealm)
    func delete(item: ShoppingItemRealm)
}
