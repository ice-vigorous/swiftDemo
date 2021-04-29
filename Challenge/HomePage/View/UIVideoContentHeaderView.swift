//
//  UIVideoContentHeaderView.swift
//  Challenge
//
//  Created by ice on 2020/3/16.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import ZFPlayer

class UIVideoContentHeaderView: UIBaseTableViewHeaderFooterView {
    
    lazy var videoPlayView: UIView = {
        let videoPlayView = UIView()
        videoPlayView.backgroundColor = UIColor.yellow
        return videoPlayView
    }()
    
    lazy var playerManager: ZFAVPlayerManager = {
        let playerManager = ZFAVPlayerManager()
        return playerManager
    }()
    
    lazy var controlView: ZFPlayerControlView = {
        let controlView = ZFPlayerControlView()
        
        return controlView
    }()
    
    lazy var player: ZFPlayerController = {
        let player = ZFPlayerController.init(playerManager: self.playerManager, containerView: self.videoPlayView)
        // 退到后台继续播放
        player.pauseWhenAppResignActive = false
        return player
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.backgroundColor = .gray
        return titleLabel
    }()
    
    lazy var lookImage: UIImageView = {
        let lookImage = UIImageView()
        lookImage.backgroundColor = UIColor.gray
        return lookImage
    }()
    
    lazy var lookLabel: UILabel = {
        let lookLabel = UILabel()
        lookLabel.backgroundColor = UIColor.gray
        return lookLabel
    }()
    
    lazy var collectImage: UIImageView = {
        let collectImage = UIImageView()
            collectImage.backgroundColor = UIColor.gray
        return collectImage
    }()
    
    lazy var collectLabel: UILabel = {
        let collectLabel = UILabel()
        collectLabel.backgroundColor = UIColor.gray
        return collectLabel
    }()
    
    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.backgroundColor = .gray
        return contentLabel
    }()
    
    override func configUI() {
        contentView.addSubview(videoPlayView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(lookImage)
        contentView.addSubview(lookLabel)
        contentView.addSubview(collectImage)
        contentView.addSubview(collectLabel)
        contentView.addSubview(contentLabel)
    }
    //        let urlString: String = "https://www.apple.com/105/media/cn/mac/family/2018/46c4b917_abfd_45a3_9b51_4e3054191797/films/bruce/mac-bruce-tpl-cn-2018_1280x720h.mp4"
    override func layoutSubviews() {
        super.layoutSubviews()
        player.controlView = self.controlView
        videoPlayView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(310)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        lookImage.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(10)
            make.height.width.equalTo(30)
        }
        
        lookLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lookImage.snp.top)
            make.left.equalTo(lookImage.snp.right).offset(5)
            make.height.width.equalTo(lookImage)
        }

        collectImage.snp.makeConstraints { (make) in
            make.left.equalTo(lookLabel.snp.right).offset(30)
            make.top.equalTo(lookImage.snp.top)
            make.height.width.equalTo(lookImage)
        }

        collectLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lookImage.snp.top)
            make.left.equalTo(collectImage.snp.right).offset(5)
            make.height.width.equalTo(lookImage)
        }

        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
    
    func setModel(_ model: ProductsModel) {
        if model.video_url != nil {
            self.player.assetURL = URL.init(string: model.video_url!)!
            self.player.currentPlayerManager.pause?()
        }
        titleLabel.text = "标题：最多支持两行，24个字符，多出的文字用省....标题：最多支持两行，24个字符，多出的文字用省....标题：最多支持两行，24个字符，多出的文字用省....标题：最多支持两行，24个字符，多出的文字用省....标题：最多支持两行，24个字符，多出的文字用省...."
        contentLabel.text = "标题：最多支持两行，24个字符，多出的文字用省,标题：最多支持两行，24个字符，多出的文字用省,标题：最多支持两行，24个字符，多出的文字用省,标题：最多支持两行，24个字符，多出的文字用省"
    }
}

extension UILabel {
    
    /// UILabel根据文字的需要的高度
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(
            x: 0,
            y: 0,
            width: kScreenWidth - 20,
            height: CGFloat.greatestFiniteMagnitude)
        )
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    /// UILabel根据文字实际的行数
    public var lines: Int {
        return Int(requiredHeight / font.lineHeight)
    }
}
