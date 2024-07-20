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
        
        print("isFirstLoad: \(isLoadedBefore)")
        return isLoadedBefore
    }
}
