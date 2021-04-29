//
//  ApiLoginList.swift
//  Challenge
//
//  Created by ice on 2020/3/20.
//  Copyright © 2020 ice. All rights reserved.
//

import Foundation
import Moya

enum AppLoginApi {
    /// 获取是否发送验证码
    case getVerifyCode
    case getUserInfoLoginApi(phone_number: String, sms_code: String)
}

extension AppLoginApi:TargetType{
    
    var sampleData: Data {
        return "just for test".utf8Encoded
    }
    
    var baseURL: URL {
        return URL.init(string:"http://10.0.0.43:8899")!
    }
    
    var path: String {
        switch self {
        case .getVerifyCode:
            return "auth/sms?phone_number=15266789963"
        case .getUserInfoLoginApi(phone_number: _, sms_code: _):
            return "user/login?type=1"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserInfoLoginApi(phone_number: _, sms_code: _):
            return .post
        case .getVerifyCode:
            return .post
        }
    }
    
    var task: Task {
        var parameters: [String : Any] = [:]
        switch self {
        case .getVerifyCode:
            return .requestPlain
        case let .getUserInfoLoginApi(phone_number, sms_code):
            parameters["phone_number"] = phone_number
            parameters["sms_code"] = sms_code
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json", "Authorization":"12345678"]
    }
    
}
