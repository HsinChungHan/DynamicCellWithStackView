//
//  CustomTableViewCell.swift
//  DynamicCellWithStackView
//
//  Created by Chung Han Hsin on 2024/6/4.
//

import Foundation
import UIKit

// 讓每個 cell 依照內部的 stackView 動態調整其高度

// There is a UIStackView inside the cell
// You should dynamiclly adjust the cell's heigh by UIStackView's content

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
        // TODO: - Should implement this method to update the cell content
        for item in cellModel.items {
            let label = UILabel()
            label.text = item.text
            label.backgroundColor = item.color
            stackView.addArrangedSubview(label)
        }
    }
}

// MARK: - UILayout
private extension CustomTableViewCell {
    func setupLayout() {
        // TODO: - Should do auto layout for cell
        contentView.addSubview(stackView)
    }
}

// MARK: - Factory methods
private extension CustomTableViewCell {
    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }
}
