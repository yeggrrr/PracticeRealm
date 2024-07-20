//
//  UIViewController+.swift
//  PracticeRealm
//
//  Created by YJ on 7/20/24.
//

import UIKit

extension UIViewController {
    func alertWithClose(title: String, message: String, closeTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: closeTitle, style: .default)
        alert.addAction(closeAction)
        present(alert, animated: true)
    }
    
    func alertWithOk(title: String, okButtonHander: @escaping () -> Void ) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "예", style: .default) { _ in
            okButtonHander()
        }
        
        let cancelButton = UIAlertAction(title: "아니오", style: .destructive)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        present(alert, animated: true)
    }
    
    var isLoadedBefore: Bool {
        let key = "isLoadedBefore"
        let isLoadedBefore = UserDefaults.standard.bool(forKey: key)
        
        if !isLoadedBefore {
            UserDefaults.standard.setValue(true, forKey: key)
        }
        
        return isLoadedBefore
    }
    
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
        guard !isLoadedBefore else { return }
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
