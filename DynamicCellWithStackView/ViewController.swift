//
//  ViewController.swift
//  DynamicCellWithStackView
//
//  Created by Chung Han Hsin on 2024/6/4.
//

import UIKit

class ViewController: UIViewController {
    lazy var tableView = makeTableView()
    
    // mock data
    lazy var cellModels = makeMockCellModels()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

// MARK: - UILayout
private extension ViewController {
    func setupLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - Factory Methods
private extension ViewController {
    func makeTableView() -> UITableView {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: String(describing: CustomTableViewCell.self))
        // TODO: - Configure the tableview for dynamically adjusting cell height by inner content
        tableView.dataSource = self
        return tableView
    }
    
    func randomColor() -> UIColor {
        let colors: [UIColor] = [.blue, .green, .red, .yellow, .orange, .purple, .cyan]
        return colors.randomElement()!
    }
    
    func makeMockCellModels() -> [CellModel] {
        var cellModels: [CellModel] = []
        for i in 0..<10 {
            let itemCount = Int.random(in: 1...5)
            var items: [Item] = []
            
            for j in 0..<itemCount {
                let text = "Cell\(i + 1) - Label\(j + 1)"
                let height = CGFloat.random(in: 30...100)
                let color = randomColor()
                let item = Item(text: text, height: height, color: color)
                items.append(item)
            }
            
            let cellModel = CellModel(items: items)
            cellModels.append(cellModel)
        }
        
        return cellModels
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CustomTableViewCell.self), for: indexPath) as! CustomTableViewCell
        // TODO: - Update cell's UI with indexPath
        cell.updateStackView(with: cellModels[indexPath.item])
        return cell
    }
}

// MARK: - CustomTableViewCellDelegate
extension ViewController: CustomTableViewCellDelegate {
    func customTableViewCell(_ customTableViewCell: CustomTableViewCell, isCellUpdated: Bool) {
        if !isCellUpdated { return }
        
        if let indexPath = tableView.indexPath(for: customTableViewCell) {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
