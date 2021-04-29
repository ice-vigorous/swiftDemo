//
//  UIHPHotContentCell.swift
//  Challenge
//
//  Created by ice on 2020/3/14.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit

class UIHPHotContentCell: UIBaseTableViewCell {
    lazy var black: UIImageView = {
        let black = UIImageView ()
        black.backgroundColor = .black
        return black
    }()
    lazy var line: UIImageView = {
        let line = UIImageView()
        line.backgroundColor = .black
        return line
    }()

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 13)
        titleLabel.text = "热门内容"
        return titleLabel
    }()
    
    override func configUI() {
        contentView.addSubview(black)
        contentView.addSubview(line)
        contentView.addSubview(titleLabel)
        
        black.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(5)
            make.height.equalTo(15)
            make.centerY.equalToSuperview()
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(black)
            make.left.equalTo(black.snp.right).offset(10)
            make.width.equalTo(60)
        }
        
    }
}
