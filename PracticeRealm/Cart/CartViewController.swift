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
        cartView.tableView.delegate = self
        cartView.tableView.dataSource = self
        cartView.tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.identifier)
        cartView.buyButton.addTarget(self, action: #selector(buyButtonClicked), for: .touchUpInside)
        updateTotalAmount()
    }
    
    // MARK: Functions
    func updateTotalAmount() {
        let sumTotalAmount = DataStorage.shared.cartList.map { $0.price * $0.count }.reduce(0, +)
        cartView.totalAmountLabel.text = "합계: \(sumTotalAmount.formatted())원"
    }
    
    func makeModel(item: CartItem) -> Model {
        return Model(
            titleInfoText: item.name,
            subInfoText: "\(item.price.formatted())원 * \(item.count)개 = \((item.price * item.count).formatted())원")
    }
    
    func removeToCart(row: Int) {
        let item = DataStorage.shared.cartList[row]
        DataStorage.shared.cartList[row].count -= 1
        
        if  DataStorage.shared.cartList[row].count == 0 {
            DataStorage.shared.cartList.remove(at: row)
        }
        
        let newShoppingItem = ShoppingItem(
            name: item.name,
            price: item.price,
            remainingStock: 1)
        
        if let index = DataStorage.shared.shoppingList.firstIndex(where: { $0 == newShoppingItem }) {
            DataStorage.shared.shoppingList[index].remainingStock += 1
        } else {
            DataStorage.shared.shoppingList.append(newShoppingItem)
        }
        
        updateTotalAmount()
        cartView.tableView.reloadData()
    }
    
    // MARK: Actions
    @objc func buyButtonClicked() {
        alertWithOk(title: "구매하시겠습니끼?") {
            DataStorage.shared.cartList.removeAll()
            self.updateTotalAmount()
            self.cartView.tableView.reloadData()
            self.alertWithClose(title: "구매가 완료되었습니다.", message: "", closeTitle: "확인")
        }
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataStorage.shared.cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier, for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        let item = DataStorage.shared.cartList[indexPath.row]
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
