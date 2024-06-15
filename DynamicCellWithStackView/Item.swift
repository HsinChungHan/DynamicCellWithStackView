//
//  Item.swift
//  DynamicCellWithStackView
//
//  Created by Chung Han Hsin on 2024/6/4.
//

import UIKit

struct Item {
    // text -> 在 cell 中 present 這個 text(會用 UILabel 來 present text)
    // height -> UILabel 的 height
    // color -> UILabel 的 background color
    let text: String, height: CGFloat, color: UIColor
}
