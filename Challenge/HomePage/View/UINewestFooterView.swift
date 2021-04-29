//
//  UINewestFooterView.swift
//  Challenge
//
//  Created by ice on 2020/3/16.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit

class UINewestFooterView: UIBaseTableViewHeaderFooterView {
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        return whiteView
    }()
    lazy var borderView: UIView = {
        let borderView = UIView()
        borderView.backgroundColor = .white
        borderView.layer.cornerRadius = 20
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.borderWidth = 0.5
        
        borderView.layer.shadowColor = UIColor.gray.cgColor
        borderView.layer.shadowOpacity = 0.8
        borderView.layer.shadowRadius = 0.6
        borderView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        // 这里不能设置.layer.masksToBounds = true 会与阴影冲突
        return borderView
    }()
    lazy var titleImage: UIImageView = {
        let titleImage = UIImageView ()
        titleImage.backgroundColor = .gray
        return titleImage
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "冰桶大作战"
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.backgroundColor = .gray
        return titleLabel
    }()
    
    lazy var hotLabel: UILabel = {
        let hotLabel = UILabel()
        hotLabel.text = "热度：90"
        hotLabel.font = .systemFont(ofSize: 13)
        hotLabel.backgroundColor = .gray
        return hotLabel
    }()
    
    lazy var participatorLabel: UILabel = {
        let participatorLabel = UILabel()
        participatorLabel.font = .systemFont(ofSize: 11)
        participatorLabel.text = "参与人数：111020"
        participatorLabel.backgroundColor = .gray
        return participatorLabel
    }()
    
    lazy var joinImage: UIImageView = {
        let joinImage = UIImageView()
        joinImage.backgroundColor = .blue
        return joinImage
    }()
    
    override func configUI() {
        contentView.addSubview(whiteView)
        whiteView.addSubview(borderView)
        borderView.addSubview(titleImage)
        borderView.addSubview(titleLabel)
        borderView.addSubview(hotLabel)
        borderView.addSubview(participatorLabel)
        borderView.addSubview(joinImage)
        
        whiteView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        borderView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15))
        }
        
        titleImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleImage.snp.top)
            make.left.equalTo(titleImage.snp.right).offset(10)
            make.width.equalTo(95)
            make.bottom.equalTo(hotLabel.snp.top)
        }
        
        hotLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.width.equalTo(titleLabel)
            make.height.equalTo(titleLabel)
            make.bottom.equalTo(participatorLabel.snp.top)
        }
        
        participatorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.bottom.equalTo(titleImage.snp.bottom)
            make.height.equalTo(titleLabel)
            make.width.equalTo(titleLabel)
        }
        
        joinImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
    }
    
    func setModel(model: ProductsActiModel) {
        titleLabel.text = model.title
        hotLabel.text = model.title
        participatorLabel.text = model.user_number
        
    }

}
