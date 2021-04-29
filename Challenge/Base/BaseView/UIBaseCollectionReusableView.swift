//
//  UIBaseCollectionReusableView.swift
//  Challenge
//
//  Created by ice on 2020/3/14.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import Reusable

class UIBaseCollectionReusableView: UICollectionReusableView, Reusable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI()  {}
}
