//
//  CartViewController.swift
//  PracticeRealm
//
//  Created by YJ on 7/19/24.
//

import UIKit

class CartViewController: UIViewController {
    // MARK: UI
    private let cartView = CartView()
    
    // MARK: Properties
    
    // MARK: View Life Cycle
    override func loadView() {
        view = cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
    }
    
    // MARK: Functions
    
    // MARK: Actions
}
