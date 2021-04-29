//
//  UIHomePageHotBannerCell.swift
//  Challenge
//
//  Created by ice on 2020/3/14.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import FSPagerView

class UIHPHotBannerCell: UIBaseTableViewCell {
    lazy var bannerView: FSPagerView = {
        let bannerView = FSPagerView()
        bannerView.dataSource = self
        bannerView.delegate = self
        bannerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        bannerView.automaticSlidingInterval = 5.0
        bannerView.isInfinite = false
        return bannerView
    }()
    
    lazy var imageArray: [String] = {
        let imageArray = [String]()
        return imageArray
    }()
    
    override func configUI() {
        contentView.addSubview(bannerView)
        bannerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setModelArray(_ array: [ActivityModel]) {
        for model in array {
            imageArray.append((model.images?.first)!)
        }
        bannerView.reloadData()
    }
}

extension UIHPHotBannerCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageArray.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL.init(string: imageArray[index]))
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
    
}
