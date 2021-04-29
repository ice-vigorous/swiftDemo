//
//  UserInfoManager.swift
//  Challenge
//
//  Created by ice on 2020/3/19.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit

class UserInfoManager: NSObject {

    /// 判断是否登录过并且返回用户信息
    func getUserInfoModel() -> UserInfoModel?{
        
        let userInfo = UserDefaults.standard.object(forKey:kUserInfoKey) as? UserInfoModel
        if userInfo?.token == nil{
            return nil//用户未登录
        } else {
            return userInfo!//用户登录
        }
    }
    
    /// 存储用户信息
    /// - Parameter userInfo: 用户信息model类
    func setUserInfoModel(userInfo:UserInfoModel) {
        
        UserDefaults.standard.set(userInfo, forKey: kUserInfoKey)
        UserDefaults.standard.synchronize()
    }
}
