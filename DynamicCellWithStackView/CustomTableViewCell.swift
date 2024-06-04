//
//  CustomTableViewCell.swift
//  DynamicCellWithStackView
//
//  Created by Chung Han Hsin on 2024/6/4.
//

import Foundation
import UIKit

protocol CustomTableViewCellDelegate: AnyObject {
    func customTableViewCell(_ customTableViewCell: CustomTableViewCell, indexPathDidUpdate indexPath: IndexPath)
}

class CustomTableViewCell: UITableViewCell {
    weak var delegate: CustomTableViewCellDelegate?
    
    lazy var stackView = makeStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
}

// MARK: - APIs
extension CustomTableViewCell {
    func updateStackView(with cellModel: CellModel) {
        // 清空舊的內容
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 添加新的內容並設置高度
        for item in cellModel.items {
            let label = UILabel()
            label.text = item.text
            label.backgroundColor = item.color
            stackView.addArrangedSubview(label)
            
            // 設置高度約束
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: item.height)
            ])
        }
        
        // 強制布局更新
        stackView.layoutIfNeeded()
        
        // 通知 tableView 更新高度
        if let tableView = self.superview as? UITableView {
            if let indexPath = tableView.indexPath(for: self) {
                delegate?.customTableViewCell(self, indexPathDidUpdate: indexPath)
            }
        }
    }
}

// MARK: - UILayout
private extension CustomTableViewCell {
    func setupLayout() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
}

// MARK: - Factory Methods
private extension CustomTableViewCell {
    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        return stackView
    }
}
