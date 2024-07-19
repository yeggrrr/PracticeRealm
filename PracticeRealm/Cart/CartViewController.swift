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
        cartView.totalAmountLabel.text = "합계: \(sumTotalAmount().formatted())원"
    }
    
    // MARK: Functions
    func sumTotalAmount() -> Int {
        return DataStorage.shared.cartList.map { $0.price * $0.count }.reduce(0, +)
    }
    
    func makeModel(item: CartItem) -> Model {
        return Model(
            titleInfoText: item.name,
            subInfoText: "\(item.price.formatted())원 * \(item.count)개 = \((item.price * item.count).formatted())원")
    }
    
    // MARK: Actions
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
}

extension CartViewController: UITableViewDelegate { }
