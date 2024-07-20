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
    
    struct Model {
        let titleInfoText: String
        let subInfoText: String
    }
    
    // MARK: View Life Cycle
    override func loadView() {
        view = cartView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() {
        // navigation
        navigationItem.title = "장바구니"
        
        // cartView
        cartView.tableView.delegate = self
        cartView.tableView.dataSource = self
        cartView.tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.identifier)
        cartView.buyButton.addTarget(self, action: #selector(buyButtonClicked), for: .touchUpInside)
        updateTotalAmount()
    }
    
    // MARK: Functions
    func updateTotalAmount() {
        let sumTotalAmount = CartRepository.shared.fetch().map { $0.price * $0.count }.reduce(0, +)
        cartView.totalAmountLabel.text = "합계: \(sumTotalAmount.formatted())원"
    }
    
    func makeModel(item: CartItemRealm) -> Model {
        return Model(
            titleInfoText: item.name,
            subInfoText: "\(item.price.formatted())원 * \(item.count)개 = \((item.price * item.count).formatted())원")
    }
    
    func removeToCart(row: Int) {
        let item = CartRepository.shared.fetch()[row]
        
        let newShoppingItem = ShoppingItemRealm(
            name: item.name,
            price: item.price,
            remainingStock: 1)
        
        let matchedItem = ShoppingRepository.shared.fetch().filter { shoppingItem in
            shoppingItem.name == item.name && shoppingItem.price == item.price
        }.first
        
        if let matchedItem = matchedItem {
            let newShoppingItemRealm = ShoppingItemRealm(
                id: matchedItem.id,
                name: matchedItem.name,
                price: matchedItem.price,
                remainingStock: matchedItem.remainingStock + 1)
            if matchedItem.remainingStock == 0 {
                ShoppingRepository.shared.delete(item: matchedItem)
            }
            
            ShoppingRepository.shared.update(item: newShoppingItemRealm)
        } else {
            ShoppingRepository.shared.add(item: newShoppingItem)
        }
        
        let updateCartItem = CartItemRealm(
            id: item.id,
            name: item.name,
            price: item.price,
            count: item.count - 1)
        
        if item.count == 1 {
            CartRepository.shared.delete(item: item)
        } else {
            CartRepository.shared.update(item: updateCartItem)
        }
        
        updateTotalAmount()
        cartView.tableView.reloadData()
    }
    
    // MARK: Actions
    @objc func buyButtonClicked() {
        alertWithOk(title: "구매하시겠습니끼?") {
            CartRepository.shared.deleteAll()
            
            self.updateTotalAmount()
            self.cartView.tableView.reloadData()
            self.alertWithClose(title: "구매가 완료되었습니다.", message: "", closeTitle: "확인")
        }
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartRepository.shared.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier, for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        let item = CartRepository.shared.fetch()[indexPath.row]
        let model = makeModel(item: item)
        cell.nameLabel.text = model.titleInfoText
        cell.priceLabel.text = model.subInfoText
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        removeToCart(row: indexPath.row)
    }
}

extension CartViewController: UITableViewDelegate { }
