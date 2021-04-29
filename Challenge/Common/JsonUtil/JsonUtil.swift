//
//  JsonUtil.swift
//  Challenge
//
//  Created by ice on 2020/3/12.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import HandyJSON

class JsonUtil: NSObject {
    /**
     * 在方法的func关键字之前加上关键字static或者class都可以用于指定类方法.
     * 不同的是用class关键字指定的类方法可以被子类重写.
     * 但是用static关键字指定的类方法是不能被子类重写的.
     * 根据报错信息: Class method overrides a 'final' class method.我们可以知道被static指定的类方法包含final关键字的特性--防止被重写.
     */
    
    /// Json转对象
    /// - Parameters:
    ///   - jsonStr: Json字符串
    ///   - modelType: model类型
    static func jsonToModel(_ jsonStr: String, _ modelType: HandyJSON.Type) -> BaseModel {
        if jsonStr == "" || jsonStr.count == 0 {
            #if DEBUG
            print("jsonModel:字符串为空")
            #endif
            return BaseModel()
        }
        return modelType.deserialize(from: jsonStr) as! BaseModel
    }
    
    /// Json转数组对象
    /// - Parameters:
    ///   - jsonArrayStr: Json数组字符串
    ///   - modelType: model类型
    static func jsonToArrayModel(_ jsonArrayStr: String, _ modelType: HandyJSON.Type) -> [BaseModel] {
        if jsonArrayStr == "" || jsonArrayStr.count == 0 {
            #if DEBUG
            print("jsonToModelArray:字符串为空")
            #endif
            return []
        }
        var modelArray:[BaseModel] = []
        let data = jsonArrayStr.data(using: String.Encoding.utf8)
        let peoplesArray = try! JSONSerialization.jsonObject(with:data!, options: JSONSerialization.ReadingOptions()) as? [AnyObject]
        for people in peoplesArray! {
            modelArray.append(dictionaryToModel(people as! [String : Any], modelType))
        }
        return modelArray
    }
    
    /// 字典转对象
    /// - Parameters:
    ///   - dictionStr: 字典字符串
    ///   - modelType: model类型
    static func dictionaryToModel(_ dictionStr: [String:Any], _ modelType: HandyJSON.Type) -> BaseModel {
        if dictionStr.count == 0 {
            #if DEBUG
            print("dictionaryToModel:字符串为空")
            #endif
            return BaseModel()
        }
        return modelType.deserialize(from: dictionStr) as! BaseModel
    }
    
    /// 对象转Json
    /// - Parameter model: model对象
    static func modelToJson(_ model: BaseModel?) -> String {
        if model == nil {
            #if DEBUG
            print("modelToJson:model为空")
            #endif
            return ""
        }
        return (model?.toJSONString())!
    }
    
    /// 对象转字典
    /// - Parameter model: model对象
    static func modelToDictionary(_ model: BaseModel?) -> [String:Any] {
        if model == nil {
            #if DEBUG
            print("modelToJson:model为空")
            #endif
            return [:]
        }
        return (model?.toJSON())!
    }
    
}
