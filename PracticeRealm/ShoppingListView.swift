//
//  ShoppingListView.swift
//  PracticeRealm
//
//  Created by YJ on 7/19/24.
//

import UIKit

class ShoppingListView: UIView {
    // MARK: UI
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func setConstraints() {
        
    }
    
    func configure() {
        backgroundColor = .systemBlue
    }
}
