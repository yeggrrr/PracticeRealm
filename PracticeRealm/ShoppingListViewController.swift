//
//  ShoppingListViewController.swift
//  PracticeRealm
//
//  Created by YJ on 7/18/24.
//

import UIKit
import SnapKit

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
        
        addSubviews()
        setConstraints()
        configure()
    }
    
    // MARK: Functions
    
    // MARK: Actions
}

// MARK: UITableViewDataSource
extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: UITableViewDelegate
extension ShoppingListViewController: UITableViewDelegate { }

// MARK: ViewRepresentable
extension ShoppingListViewController: ViewRepresentable {
    func addSubviews() {
        view.addSubview(shoppingListView)
    }
    
    func setConstraints() {
        shoppingListView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure() {
        shoppingListView.tableView.delegate = self
        shoppingListView.tableView.dataSource = self
    }
}
