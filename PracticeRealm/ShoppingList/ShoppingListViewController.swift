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
        shoppingListView.tableView.delegate = self
        shoppingListView.tableView.dataSource = self
        shoppingListView.tableView.register(ShoppingListTableViewCell.self, forCellReuseIdentifier: ShoppingListTableViewCell.identifier)
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
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "닫기", style: .default)
        alert.addAction(closeAction)
        present(alert, animated: true)
    }
    
    // MARK: Actions
}

// MARK: UITableViewDataSource
extension ShoppingListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier, for: indexPath) as? ShoppingListTableViewCell else { return UITableViewCell() }
        let item = shoppingList[indexPath.row]
        cell.nameLabel.text = "\(item.name) (남은수량: \(item.remainingStock)개)"
        cell.priceLabel.text = item.price.formatted() + "원"
        return cell
    }
}

// MARK: UITableViewDelegate
extension ShoppingListViewController: UITableViewDelegate { }
