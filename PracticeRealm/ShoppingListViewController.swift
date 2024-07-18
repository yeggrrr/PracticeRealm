//
//  ShoppingListViewController.swift
//  PracticeRealm
//
//  Created by YJ on 7/18/24.
//

import UIKit

class ShoppingListViewController: UIViewController {
    // MARK: UI
    private let shoppingListView = ShoppingListView()
    
    // MARK: Properties
    
    // MARK: View Life Cycle
    override func loadView() {
        view = shoppingListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Configure
    
    // MARK: Functions
    
    // MARK: Actions
}

