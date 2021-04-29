//
//  UIBaseTableViewCell.swift
//  Challenge
//
//  Created by ice on 2020/3/14.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import Reusable
import SnapKit
import Kingfisher

// Mark 遵守Reusable协议
class UIBaseTableViewCell: UITableViewCell, Reusable {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}
