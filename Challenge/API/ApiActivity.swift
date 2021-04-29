//
//  ApiActivity.swift
//  Challenge
//
//  Created by ice on 2020/3/12.
//  Copyright © 2020 ice. All rights reserved.
//

import Foundation
import Moya

/// 首页活动请求方法
enum ActivityApi {
    /// 首页-热门内容（limit: 返回条数）
    case requestHPTopContent(_ limit: Int)
    /// 首页-热门活动（limit: 返回条数）
    case requestHPHotActivity(_ limit: Int)
    /// 首页-活动宣传（limit: 返回条数）
    case requestHPPropagandize(_ limit: Int)
    /// 首页-获取活动详情页(id: 活动id)
    case requestHPActivityDetails(_ id: Int)
}

extension ActivityApi: TargetType {
    // 请求服务器的根路径
    var baseURL: URL { return URL.init(string: BaseUrl)! }
    
    // 每个Api对应的具体路径
    var path: String {
        switch self {
        case let .requestHPActivityDetails(id):
            return "/activities/" + String(id)
        default:
            return "/activities"
        }
    }
    
    // 各个接口的请求方式，get或post
    var method: Moya.Method { return .get }
    
    // 单元测试使用
    var sampleData: Data { return "just for test".utf8Encoded }
    
    // 请求是否携带参数
    var task: Task {
        var parameters: [String : Any] = [:]
        switch self {
        case .requestHPTopContent(let limit):
            parameters["limit"] = limit
            // WARING
            parameters["sort"]  = 1
            
        case .requestHPHotActivity(let limit):
            parameters["limit"] = limit
            parameters["is_push"]  = "true"
            
        case .requestHPPropagandize(let limit):
            parameters["limit"] = limit
            parameters["is_recommend"]  = "true"
            
        case .requestHPActivityDetails( _): return .requestPlain
            
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    // 请求头
    var headers: [String : String]? { return ["Content-type" : "application/json", "Authorization":"12345678"] }
    
}
