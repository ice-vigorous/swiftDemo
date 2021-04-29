//
//  ApiManager.swift
//  Challenge
//
//  Created by ice on 2020/3/13.
//  Copyright © 2020 ice. All rights reserved.
//

import Foundation
import ObjectMapper
import HandyJSON
import RxSwift
import Moya

//struct ReturnData<T: HandyJSON>: HandyJSON {
//    var message:String?
//    var returnData: T?
//    var stateCode: Int = 0
//}
//
//struct ResponseData<T: HandyJSON>: HandyJSON {
//    var code: Int = 0
//    var data: ReturnData<T>?
//}
//
//extension MoyaProvider {
//
//    func requestObjectMapper<T: BaseMappable>(_ target: Target, completion: (_ reyurnData: T?) -> Void?) -> Cancelable {
//        return request(target) { (result) in
//
//        }
//    }
//    @discardableResult
//    open func requestHandyJSON<T: HandyJSON>(_ target: Target,
//                                    model: T.Type,
//                                    completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {
//
//        return request(target, completion: { (result) in
//            guard let completion = completion else { return }
//            guard let returnData = try? result.value?.mapHandyJsonModel(ResponseData<T>.self) else {
//                completion(nil)
//                return
//            }
//            completion(returnData.data?.returnData)
//        })
//    }
//}

//
extension ObservableType where E == Response {
    // 使用ObjectMapper
    // 将Json解析为Observable<Model>
    public func mapObjectModel<T: BaseMappable>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(try response.mapObjectModel(T.self))
        }
    }
    // 将Json解析为Observable<[Model]>
    public func mapObjectArray<T: BaseMappable>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(try response.mapObjectArray(T.self))
        }
    }
    
    // 使用HandyJson
    // 将Json解析为Observable<Model>
    public func mapHandyJsonModel<T: HandyJSON>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            return Observable.just(response.mapHandyJsonModel(T.self))
        }
    }
    // 将Json解析为Observable<[Model]>
    public func mapHandyJsonArray<T: HandyJSON>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            return Observable.just(response.mapHandyJsonModelArray(T.self))
        }
    }
}

// MARK: - Json -> Model
extension Response {
    // 使用ObjectMapper
    // Json -> Model
    func mapObjectModel<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) throws -> T {
        guard let object = Mapper<T>(context: context).map(JSONObject: try mapJSON()) else {
            throw MoyaError.jsonMapping(self)
        }
        return object
    }
    // Json -> Model Array
    func mapObjectArray<T: BaseMappable>(_ type: T.Type, context: MapContext? = nil) throws -> [T] {
        guard let array = try mapJSON() as? [[String : Any]] else {
            throw MoyaError.jsonMapping(self)
        }
        return Mapper<T>(context: context).mapArray(JSONArray: array)
    }
    
    // 使用HandyJSON
    // Json -> Model
    func mapHandyJsonModel<T: HandyJSON>(_ type: T.Type) -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            fatalError()
        }
        return model
    }
    // Json -> Model Array
    func mapHandyJsonModelArray<T: HandyJSON>(_ type: T.Type) -> [T] {
        let jsonString = String(data: data, encoding: .utf8)
        guard let array:[T] = JSONDeserializer<T>.deserializeModelArrayFrom(json: jsonString) as? [T] else {
            fatalError()
        }
        return array
    }
}
