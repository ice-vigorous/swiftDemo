//
//  ApiMyWorksList.swift
//  Challenge
//
//  Created by ice on 2020/3/17.
//  Copyright © 2020 ice. All rights reserved.
//

import Foundation
import Moya

/// 获取我的作品Api
enum MyWorksListApi {
    /**
     *page: 分页页数 per_page: 每页页数
     *start_date: 开始日期，格式：yyyy-MM-dd,当不存在时，表示起始日期不限
     *end_date: 截止日期，格式：yyyy-MM-dd，当不存在时，表示截止日期不限
     *sort: 排序依据 1 用户，2 热度，3 参与人数，4 评论数， 5 收藏数，6 播放量
     */
    case getMyWorksList(uid: String, page: Int, per_page: Int, start_date: String, end_date: String, sort: Int)
}

extension MyWorksListApi:TargetType{
    
    var sampleData: Data {
        return "just for test".utf8Encoded
    }
    
    var baseURL: URL {
        return URL.init(string:"http://10.0.0.43:8899")!
    }
    
    var path: String {
        return "products/products-activities"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        var parameters: [String : Any] = [:]
        switch self {
        case let .getMyWorksList(uid, page, per_page, start_date, end_date, sort):
            parameters["uid"] = uid
            parameters["page"] = page
            parameters["per_page"] = per_page
            parameters["start_date"] = start_date
            parameters["end_date"] = end_date
            parameters["sort"] = sort
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json", "Authorization":"12345678"]
    }
    
}
