//
//  ApiActivityList.swift
//  Challenge
//
//  Created by ice on 2020/3/12.
//  Copyright © 2020 ice. All rights reserved.
//

import Foundation
import Moya

/// 活动列表请求方法
enum ActivityListApi {
    /**
     *page: 分页页数 per_page: 每页条数
     *start_date: 开始日期，格式：yyyy-MM-dd,当不存在时，表示起始日期不限
     *end_date: 截止日期，格式：yyyy-MM-dd，当不存在时，表示截止日期不限
     *sort: 排序依据 1 热度，2 参与人数，3 评论数， 4 收藏数，5 播放量
     */
    case getMoreActivity(page: Int, per_page: Int, start_date: String, end_date: String, sort: Int)
}

extension ActivityListApi: TargetType{
    var baseURL: URL { return URL.init(string: BaseUrl)! }
    
    var path: String { return "/activities"}
    
    var method: Moya.Method { return .get }
    
    var sampleData: Data { return "just for test".utf8Encoded }
    
    var task: Task {
        var parameters: [String : Any] = [:]
        switch self {
        case let .getMoreActivity(page, per_page, start_date, end_date, sort ):
            parameters["page"] = page
            parameters["per_page"] = per_page
            parameters["start_date"] = start_date
            parameters["end_date"] = end_date
            parameters["sort"] = sort
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? { return ["Content-type" : "application/json", "Authorization":"12345678"] }
}
