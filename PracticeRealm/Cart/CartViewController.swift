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
    var cartList: [CartItem] = [CartItem(name: "복숭아", price: 3000, count: 5)]
    
    // MARK: View Life Cycle
    override func loadView() {
        view = cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        cartView.tableView.delegate = self
        cartView.tableView.dataSource = self
        cartView.tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.identifier)
    }
    
    // MARK: Functions
    
    // MARK: Actions
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier, for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        let item = cartList[indexPath.row]
        cell.nameLabel.text = item.name
        cell.priceLabel.text = "\(item.price.formatted())원 * \(item.count)개 = \((item.price * item.count).formatted())원"
        return cell
    }
}

extension CartViewController: UITableViewDelegate { }
