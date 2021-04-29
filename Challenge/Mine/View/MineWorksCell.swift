//
//  MineWorksCell.swift
//  Challenge
//
//  Created by ice on 2020/3/16.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit

class MineWorksCell: UIBaseTableViewCell {

    override func configUI() {
        self.addSubview(avatar)
        self.addSubview(userName)
        self.addSubview(publishTime)
        self.addSubview(activityDesc)
        self.addSubview(thumbnail)
    }
    
    lazy var avatar:UIImageView = {
        let imageV = UIImageView()
        imageV.layer.cornerRadius = 15
        imageV.backgroundColor = UIColor.yellow
        return imageV
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: kCellTitleFont)
        label.textAlignment = .left
        return label
    }()
    
    lazy var publishTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: kCellTimeFont)
        label.textAlignment = .right
        return label
    }()
    
    lazy var activityDesc: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: kCellTitleFont)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    lazy var thumbnail: UIImageView = {
        let image = UIImageView()
        return image;
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        avatar.snp.makeConstraints { (item) in
            item.left.equalTo(self).offset(kCellLeftMargin)
            item.top.equalTo(self).offset(kCellTopMargin)
            item.height.width.equalTo(40)
        }
        
        publishTime.snp.makeConstraints { (item) in
            item.right.equalTo(self).offset(-kCellLeftMargin)
            item.centerY.equalTo(avatar)
            item.height.equalTo(20)
            item.width.equalTo(120)
        }
        
        userName.snp.makeConstraints { (item) in
            item.left.equalTo(avatar.snp_right).offset(kCommonMargin)
            item.right.equalTo(publishTime.snp_left).offset(-kCommonMargin)
            item.centerY.equalTo(avatar)
            item.height.equalTo(20)
        }
        
        activityDesc.snp.makeConstraints { (item) in
            item.left.equalTo(avatar)
            item.right.equalTo(publishTime)
            item.top.equalTo(avatar.snp_bottom).offset(kCellTopMargin)
            item.height.equalTo(50)
        }
        
        thumbnail.snp.makeConstraints { (item) in
            item.left.right.equalTo(activityDesc)
            item.top.equalTo(activityDesc.snp_bottom).offset(kCellTopMargin)
            item.height.equalTo((kScreenWidth - 2*kCellLeftMargin)*2/3.0)
        }
    }
    
    
    
    func loadData(model:MyWorksCellModel) {
        self.userName.text = model.user?.nick_name
        self.publishTime.text = model.publish_date
        self.activityDesc.text = model.description
        self.thumbnail.kf.setImage(with: URL(string: model.video_cover!))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
