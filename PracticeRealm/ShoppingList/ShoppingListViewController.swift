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
    
    struct Model {
        let titleInfoText: String
        let subInfoText: String
    }
    
    
    // MARK: View Life Cycle
    override func loadView() {
        view = shoppingListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        if !isLoadedBefore {
            DataStorage.shared.initData()
        }
        
        ShoppingRepository.shared.findFilePath()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        shoppingListView.tableView.reloadData()
    }
    
    func configure() {
        // shoppingListView
        shoppingListView.tableView.delegate = self
        shoppingListView.tableView.dataSource = self
        shoppingListView.tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.identifier)
        
        // navigation
        navigationItem.title = "상품 목록"
        let cartBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(cartBarButtonClicked))
        navigationItem.rightBarButtonItem = cartBarButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .systemPink
    }
    
    // MARK: Functions
    func makeModel(item: ShoppingItemRealm) -> Model {
        return Model(
            titleInfoText: "\(item.name) (남은수량: \(item.remainingStock)개)",
            subInfoText: item.price.formatted() + "원")
    }
    
    func addToCart(row: Int) {
        let item = ShoppingRepository.shared.fetch()[row]
        guard item.remainingStock != 0 else { return }
        
        let newShoppingItem = ShoppingItemRealm(
            id: item.id,
            name: item.name,
            price: item.price,
            remainingStock: item.remainingStock - 1)
        
        ShoppingRepository.shared.update(item: newShoppingItem)
        
        let newCartItem = CartItem(
            name: item.name,
            price: item.price,
            count: 1)
        
        if let index = DataStorage.shared.cartList.firstIndex(where: { $0 == newCartItem }) {
            DataStorage.shared.cartList[index].count += 1
        } else {
            DataStorage.shared.cartList.append(newCartItem)
        }
        
        shoppingListView.tableView.reloadData()
    }
    
    // MARK: Actions
    @objc func cartBarButtonClicked() {
        let vc = CartViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: UITableViewDataSource
extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingRepository.shared.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier, for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        let item = ShoppingRepository.shared.fetch()[indexPath.row]
        let model = makeModel(item: item)
        cell.nameLabel.text = model.titleInfoText
        cell.priceLabel.text = model.subInfoText
        if item.remainingStock == 0 {
            cell.nameLabel.textColor = .systemPink
            cell.priceLabel.textColor = .systemPink
        } else {
            cell.nameLabel.textColor = .label
            cell.priceLabel.textColor = .label
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addToCart(row: indexPath.row)
    }
}

// MARK: UITableViewDelegate
extension ShoppingListViewController: UITableViewDelegate { }
