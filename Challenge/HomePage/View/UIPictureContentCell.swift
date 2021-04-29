//
//  UIPictureContentCell.swift
//  Challenge
//
//  Created by ice on 2020/3/19.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit

class UIPictureContentCell: UIBaseTableViewCell {
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.backgroundColor = .gray
        return titleLabel
    }()
    
    lazy var headerImage: UIImageView = {
        let headerImage = UIImageView()
        headerImage.backgroundColor = .gray
        return headerImage
    }()
    
    lazy var nickLabel: UILabel = {
        let nickLabel = UILabel()
        nickLabel.backgroundColor = .gray
        return nickLabel
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.backgroundColor = .gray
        return timeLabel
    }()
    
    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.backgroundColor = .gray
        return contentLabel
    }()
    
    override func configUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(headerImage)
        contentView.addSubview(nickLabel)
        contentView.addSubview(timeLabel)
    }

}
