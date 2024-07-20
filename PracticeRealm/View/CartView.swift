//
//  CartView.swift
//  PracticeRealm
//
//  Created by YJ on 7/19/24.
//

import UIKit
import SnapKit

class CartView: UIView {
    // MARK: UI
    let tableView = UITableView()
    let containerView = UIView()
    let verticalStackView = UIStackView()
    let totalAmountLabel = UILabel()
    let buyButton = UIButton()
    
    // MARK: Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addsubviews()
        setConstraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configure
    func addsubviews() {
        addSubviews([tableView, containerView])
        containerView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubviews([totalAmountLabel, buyButton])
    }
    
    func setConstraints() {
        tableView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(containerView.snp.top)
        }
        
        containerView.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
    
    func configure() {
        backgroundColor = .white
        containerView.backgroundColor = .systemGray3
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        
        totalAmountLabel.text = "dnririri"
        buyButton.setTitle("구매하기", for: .normal)
        buyButton.backgroundColor = .systemCyan
    }
}
