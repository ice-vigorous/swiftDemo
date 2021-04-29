//
//  ActivityModel.swift
//  Challenge
//
//  Created by ice on 2020/3/14.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import ObjectMapper

class ActivityModel: Mappable {
    /// 活动id
    var int: Int?
    /// 奖品id
    var prize_id: Int?
    /// 图片列表
    var images: [String]?
    /// 图标
    var icon: String?
    /// 标题
    var title: String?
    /// 描述
    var description: String?
    /// 截止日期
    var closing_date: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        int <- map["int"]
        prize_id <- map["prize_id"]
        images <- map["images"]
        icon <- map["icon"]
        title <- map["title"]
        description <- map["description"]
        closing_date <- map["closing_date"]
    }
}

//struct ActivitySections {
//    //
//    var header: String?
//    var items: [ActivityModel]
//}
//
//extension ActivitySections: SectionModelType{
//    typealias Item = ActivityModel
//    init(original: ActivitySections, items: [ActivityModel]) {
//        self = original
//        self.items = items
//    }
//}

// MARK: - 使用HandyJSON创建model的两种方法
//struct ActivityModel: HandyJSON {
//    /// 活动id
//    var int: Int?
//    /// 奖品id
//    var prize_id: Int?
//    /// 图片列表
//    var images: [String]?
//    /// 图标
//    var icon: String?
//    /// 标题
//    var title: String?
//    /// 描述
//    var description: String?
//    /// 截止日期
//    var closing_date: String?
//}

//class ActivityModel: BaseModel {
//    /// 活动id
//    var int: Int?
//    /// 奖品id
//    var prize_id: Int?
//    /// 图片列表
//    var images: [String]?
//    /// 图标
//    var icon: String?
//    /// 标题
//    var title: String?
//    /// 描述
//    var description: String?
//    /// 截止日期
//    var closing_date: String?
//}
