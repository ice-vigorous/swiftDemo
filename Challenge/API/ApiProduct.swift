//
//  ApiProduct.swift
//  Challenge
//
//  Created by ice on 2020/3/12.
//  Copyright © 2020 ice. All rights reserved.
//

import Foundation
import Moya

/// 作品内容请求方法
enum ProductApi {
    /// 获取作品内容(内容详情页id: 作品id)
    case requestProductDetails(_ id: Int)
    /// 发布作品(活动 id: activity_id, 作品类型 1，视频作品，2 图文作品: type, 视频地址: video_url, 视频封面: video_cover，视频时长: video_duration,视频尺寸: video_size,图片地址: images,标题: title,描述: description)
    case publishProduct(_ activity_id: Int, type: Int, video_url: String, video_cover: String, video_duration: Int, video_size: Int, images: [String], title: String, description: String)
    /// 获取时间段内热门作品及其活动(热门活动和最新活动列表)
    /// (page: 分页页数, per_page: 每条页数, start_date: 开始日期，格式：yyyy-MM-dd，当不存在时，表示起始日期不限, end_date: 截止日期，格式：yyyy-MM-dd，当不存在时，表示截止日期不限, sort: 排序依据 1 热度，2 参与人数，3 评论数， 4 收藏数，5 播放量)
    case requestHotProductList(_ page: Int, per_page: Int, start_date: String, end_date: String, sort: Int)
    /// 获取活动对应的作品列表（活动详情页-热门内容）
    /// (activity_id: 活动 id, page: 分页页数, per_page: 每页条数, start_date: 开始日期，格式：yyyy-MM-dd，当不存在时，表示起始日期不限, end_date: 截止日期，格式：yyyy-MM-dd，当不存在时，表示截止日期不限, sort: 排序依据 1 热度，2 参与人数，3 评论数， 4 收藏数，5 播放量)
    case requestProductList(_ activity_id: Int, page: Int, per_page: Int, start_date: String, end_date: String, sort: Int)
    /// 获取用户的作品列表（个人详情页作品部分）
    /// (uid: 用户 id, page: 分页页数, per_page: 每页条数, start_date: 开始日期，格式：yyyy-MM-dd，当不存在时，表示起始日期不限, end_date: 截止日期，格式：yyyy-MM-dd，当不存在时，表示截止日期不限, sort: 排序依据 1 热度，2 参与人数，3 评论数， 4 收藏数，5 播放量)
    case requestPersonalProductList(_ uid: Int, page: Int, per_page: Int, start_date: String, end_date: String, sort: Int)
}

extension ProductApi: TargetType {
    // 请求服务器的根路径
    var baseURL: URL { return URL.init(string: BaseUrl)! }
    
    // 每个Api对应的具体路径
    var path: String {
        switch self {
        case .requestProductDetails(let id)
            : return "/products/" + String(id)
        case  .publishProduct(_, type: _, video_url: _, video_cover: _, video_duration: _, video_size: _, images: _, title: _, description: _),
             .requestProductList(_, page: _, per_page: _, start_date: _, end_date: _, sort: _)
            : return "/products"
        case .requestHotProductList(_, per_page: _, start_date: _, end_date: _, sort: _),
             .requestPersonalProductList(_, page: _, per_page: _, start_date: _, end_date: _, sort: _)
            : return "/products/products-activities"
        }
    }
    
    // 各个接口的请求方式，get或post
    var method: Moya.Method {
        switch self {
        case .requestProductDetails(_),
             .requestHotProductList(_, per_page: _, start_date: _, end_date: _, sort: _),
             .requestProductList(_, page: _, per_page: _, start_date: _, end_date: _, sort: _),
             .requestPersonalProductList(_, page: _, per_page: _, start_date: _, end_date: _, sort: _)
            : return .get
            
        case .publishProduct(_, type: _, video_url: _, video_cover: _, video_duration: _, video_size: _, images: _, title: _, description: _)
            : return .post
        }
    }
    
    // 单元测试使用
    var sampleData: Data { return "just for test".utf8Encoded }
    
    // 请求是否携带参数
    var task: Task {
        var parameters: [String : Any] = [:]
        switch self {
        case .requestProductDetails(_): return .requestPlain
        case let .publishProduct(activity_id, type, video_url, video_cover, video_duration, video_size, images, title, description):
            parameters["activity_id"] = activity_id
            parameters["type"]  = type
            parameters["video_url"]  = video_url
            parameters["video_cover"]  = video_cover
            parameters["video_duration"]  = video_duration
            parameters["video_size"]  = video_size
            parameters["images"]  = images
            parameters["title"]  = title
            parameters["description"]  = description
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case let .requestHotProductList(page, per_page, start_date, end_date, sort):
            parameters["page"] = page
            parameters["per_page"]  = per_page
            parameters["start_date"]  = start_date
            parameters["end_date"]  = end_date
            parameters["sort"]  = sort
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case let .requestProductList(activity_id, page, per_page, start_date, end_date, sort):
            parameters["activity_id"] = activity_id
            parameters["page"]  = page
            parameters["per_page"]  = per_page
            parameters["start_date"]  = start_date
            parameters["end_date"]  = end_date
            parameters["sort"]  = sort
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
        case let .requestPersonalProductList(uid, page, per_page, start_date, end_date, sort):
            parameters["uid"] = uid
            parameters["page"]  = page
            parameters["per_page"]  = per_page
            parameters["start_date"]  = start_date
            parameters["end_date"]  = end_date
            parameters["sort"]  = sort
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    // 请求头
    var headers: [String : String]? { return ["Content-type" : "application/json", "Authorization":"12345678"] }
    
}


