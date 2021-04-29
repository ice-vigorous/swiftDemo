//
//  UIHPContentCell.swift
//  Challenge
//
//  Created by ice on 2020/3/14.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UIHPContentCell: UIBaseTableViewCell {
    
    let click = UITapGestureRecognizer()
    var disposeBag = DisposeBag()
    
    lazy var headerImage: UIImageView = {
        let headerImage = UIImageView()
        headerImage.backgroundColor = .gray
        headerImage.isUserInteractionEnabled = true
        return headerImage
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.backgroundColor = .gray
        nameLabel.isUserInteractionEnabled = true
        return nameLabel
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.backgroundColor = .gray
        timeLabel.isUserInteractionEnabled = true
        return timeLabel
    }()
    
    lazy var contentImage: UIImageView = {
        let contentImage = UIImageView()
        contentImage.backgroundColor = .gray
        return contentImage
    }()
    
    //单元格重用时调用
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func configUI() {
        contentView.addSubview(headerImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(contentImage)
        //let click = UITapGestureRecognizer(target: self, action: #selector(clickEvent))
        
        headerImage.addGestureRecognizer(click)
//        nameLabel.addGestureRecognizer(click)
//        timeLabel.addGestureRecognizer(click)
    }
    @objc func clickEvent() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerImage.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(10)
            $0.width.height.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(headerImage.snp.top)
            $0.left.equalTo(headerImage.snp.right).offset(10)
            $0.height.equalTo(25)
            $0.width.equalTo(80)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(nameLabel.snp.left)
            make.bottom.equalTo(headerImage.snp.bottom)
            make.width.equalTo(90)
        }
        
        contentImage.snp.makeConstraints { (make) in
            make.left.equalTo(headerImage.snp.left)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(headerImage.snp.bottom).offset(5)
            make.bottom.equalToSuperview()
        }
    }
    
    func setModel(_ model: ProductsModel) {
        nameLabel.text = model.user?.nick_name
        timeLabel.text = model.publish_date
        headerImage.kf.setImage(with: URL.init(string: (model.images![0])))
        contentImage.kf.setImage(with: URL.init(string: (model.images![0])))
    }
}
