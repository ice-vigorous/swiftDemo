//
//  UIBaseTableViewHeaderFooterView.swift
//  Challenge
//
//  Created by ice on 2020/3/14.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import Reusable

class UIBaseTableViewHeaderFooterView: UITableViewHeaderFooterView, Reusable {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    open func configUI() {}
}
