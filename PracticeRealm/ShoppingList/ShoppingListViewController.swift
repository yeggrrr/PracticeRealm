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
    var shoppingList: [ShoppingItem] = []
    
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
        getShoppingList()
    }
    
    func configure() {
        // shoppingListView
        shoppingListView.tableView.delegate = self
        shoppingListView.tableView.dataSource = self
        shoppingListView.tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.identifier)
        
        // navigation
        let cartBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(cartBarButtonClicked))
        navigationItem.rightBarButtonItem = cartBarButtonItem
        navigationItem.rightBarButtonItem?.tintColor = .systemPink
    }
    
    // MARK: Functions
    func load(fileName: String) -> Data? {
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: "json") else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            return nil
        }
    }
    
    func getShoppingList() {
        guard let data = load(fileName: "ShoppingData") else { return }
        
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ShoppingList.self, from: data)
            shoppingList = result.list
            shoppingListView.tableView.reloadData()
        } catch {
            shoppingList = []
            showAlert(title: "⚠️", message: "데이터를 가자오는데 실패했습니다.\n다시 시도해주세요.")
        }
    }
    
    func makeModel(item: ShoppingItem) -> Model {
        return Model(
            titleInfoText: "\(item.name) (남은수량: \(item.remainingStock)개)",
            subInfoText: item.price.formatted() + "원")
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "닫기", style: .default)
        alert.addAction(closeAction)
        present(alert, animated: true)
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
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier, for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        let item = shoppingList[indexPath.row]
        let model = makeModel(item: item)
        cell.nameLabel.text = model.titleInfoText
        cell.priceLabel.text = model.subInfoText
        return cell
    }
}

// MARK: UITableViewDelegate
extension ShoppingListViewController: UITableViewDelegate { }
