//
//  UIBaseViewController.swift
//  Challenge
//
//  Created by ice on 2020/3/10.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import SnapKit
import Then
import Kingfisher
import RxDataSources
import RxCocoa
import RxSwift
import MJRefresh
import Hue

class UIBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 解决ios11 由于安全区域safeArea问题造成的表的向下偏移
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.view.backgroundColor = UIColor.white
        configUI()
        bindData()
        // Do any additional setup after loading the view.
    }
    func bindData() {}
    /// 视图布局
    func configUI() {}
    
    func emptyLoading() { loadData() }
    
    /// 加载数据
    func loadData() { }
    /// 加载更多
    func loadMoreData() { }
}
