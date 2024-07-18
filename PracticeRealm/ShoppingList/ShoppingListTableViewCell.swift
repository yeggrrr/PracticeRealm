//
//  ShoppingListTableViewCell.swift
//  PracticeRealm
//
//  Created by YJ on 7/19/24.
//

import UIKit
import SnapKit

class ShoppingListTableViewCell: UITableViewCell, ViewRepresentable {
    // MARK: UI
    let verticalStackView = UIStackView()
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    
    // MARK: Properties
    static let identifier = String(describing: ShoppingListTableViewCell.self)
    
    // MARK: Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        setConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func addSubviews() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubviews([nameLabel, priceLabel])
    }
    
    func setConstraints() {
        verticalStackView.snp.makeConstraints {
            $0.edges.equalTo(contentView.snp.edges).inset(16)
        }
        
        nameLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(verticalStackView.snp.horizontalEdges)
        }
        
        priceLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(verticalStackView.snp.horizontalEdges)
        }
    }
    
    func configure() {
        // verticalStackView
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .fillEqually
        
        // nameLabel
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        // priceLabel
        priceLabel.font = .systemFont(ofSize: 16, weight: .regular)
    }
}
