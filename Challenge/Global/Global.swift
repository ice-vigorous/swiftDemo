//
//  Global.swift
//  Challenge
//
//  Created by ice on 2020/3/12.
//  Copyright © 2020 ice. All rights reserved.
//

import Foundation
import UIKit

//MARK: print
func Eric_Log<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("[\(fileName):funciton:\(function):line:\(lineNumber)]- \(message)")
    #endif
}

// 屏幕宽高
let kScreenWidth  = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

// 导航栏和tabBar 的高度
let kNavBarHeight: CGFloat = isIphoneX ? 88 : 64
let kTabBarHeight: CGFloat = isIphoneX ? 83 : 49

let kStatusBarHeight: CGFloat = isIphoneX ? 44 : 20
let kSafeAreaHeight: CGFloat = isIphoneX ? 34 : 0

// 当前视图
var currentVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}
private func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

var isIphoneX: Bool {
    return UI_USER_INTERFACE_IDIOM() == .phone
        && (max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 812
        || max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896)
}

//网络请求时保证字符串是安全的
func SafeString(string:String) ->String{
   var handleStr = string
    if handleStr.isEmpty {
        handleStr = ""
    }
    return handleStr
}

let kBannerKey = "banner"
let kHotKey = "hot"
let kContentKey = "content"
let kListKey = "list"

/// cell间距相关
let kCellLeftMargin = CGFloat(5)
let kCellTopMargin = CGFloat(8)
let kCommonMargin = CGFloat(10)


/// 字体相关
let kBarTitleFont = CGFloat(25)
let kCellTitleFont = CGFloat(18)
let kCellDescFont = CGFloat(14)
let kCellTimeFont = CGFloat(12)


/// 用户信息相关
let kUserInfoKey = "userInfoModel"
