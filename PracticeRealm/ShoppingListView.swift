//
//  ShoppingListView.swift
//  PracticeRealm
//
//  Created by YJ on 7/19/24.
//

import UIKit
import SnapKit

class ShoppingListView: UIView, ViewRepresentable {
    // MARK: UI
    let tableView = UITableView()
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func addSubviews() {
        addSubview(tableView)
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure() {
        backgroundColor = .systemBlue
    }
}
