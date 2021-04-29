//
//  ProductsModel.swift
//  Challenge
//
//  Created by ice on 2020/3/17.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit

class ProductsModel: BaseModel {
    /// 作品id
    var id: Int?
    /// 作品类型 1，视频作品，2 图文作品
    var type: Int?
    /// 视频地址
    var video_url: String?
    /// 视频封面地址
    var video_cover: String?
    /// 视频时长
    var video_duration: Int?
    /// 视频尺寸
    var video_size: Int?
    /// 图片地址
    var images: [String]?
    /// 标题
    var title: String?
    /// 描述
    var description: String?
    /// 审核状态,1 待审核, 2 审核通过,3 审核失败
    var audit_status: Int?
    /// 审核失败原因
    var audit_message: String?
    /// 发布时间
    var publish_date: String?
    /// 用户信息
    var user: ProductsUserModel?
    /// 活动信息
    var activity: ProductsActiModel?
}

class ProductsUserModel: BaseModel {
    /// 用户id
    var uid: String?
    /// 用户昵称
    var nick_name: String?
    /// 用户头像
    var headimg: String?
}

class ProductsActiModel: BaseModel {
    /// 活动id
    var id: String?
    /// 活动标题
    var title: String?
    /// 活动参与人数
    var user_number: String?
    /// 活动热度
    var hot : String?
    
}
