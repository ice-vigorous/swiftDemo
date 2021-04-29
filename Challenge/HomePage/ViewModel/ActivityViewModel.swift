//
//  ActivityViewModel.swift
//  Challenge
//
//  Created by ice on 2020/3/14.
//  Copyright © 2020 ice. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxCocoa

class ActivityViewModel {
    private let provider = MoyaProvider<ActivityApi>()
    private let listProvider = MoyaProvider<ProductApi>()
    let disposeBag = DisposeBag()
    var hotBannSource = BehaviorRelay<[ActivityModel]>(value: [])
    var hotActiSource = BehaviorRelay<[ActivityModel]>(value: [])
    var hotContSource = BehaviorRelay<[ActivityModel]>(value: [])
    var hotListSource = BehaviorRelay<[ProductsModel]>(value: [])
    var networkError = BehaviorRelay(value: MoyaError.self)
}

// MARK: - 网络
extension ActivityViewModel {
    //MARK: - 网络请求：使用ObjectMapper
    // Banner 活动宣传页
    func requestBannSource(_ limit: Int) {
        provider.rx.request(.requestHPPropagandize(limit)).asObservable().mapObjectArray(ActivityModel.self).subscribe({ [weak self] (event) in
            switch event {
            case let  .next(classModel):
                self?.hotBannSource.accept(classModel)
                print("banner -- 加载网络成功:",classModel)
            case let .error( error):
                print("error:",error.localizedDescription)
                //self?.networkError.accept(error as! MoyaError.self)
            case .completed: break
            }
        }).disposed(by: disposeBag)
    }
    // 热门活动
    func requestHotActiSource(_ limit: Int) {
        provider.rx.request(.requestHPHotActivity(limit)).asObservable().mapObjectArray(ActivityModel.self).subscribe({ [weak self] (event) in
            switch event {
            case let  .next(classModel):
                self?.hotActiSource.accept(classModel)
                print("热门活动 -- 加载网络成功:",classModel)
            case let .error( error):
                print("error:",error)
            case .completed: break
            }
        }).disposed(by: disposeBag)
    }
    // 热门内容
    func requestHotContSource(_ limit: Int) {
        provider.rx.request(.requestHPTopContent(limit)).asObservable().mapObjectArray(ActivityModel.self).subscribe({ [weak self] (event) in
            switch event {
            case let  .next(classModel):
                self?.hotContSource.accept(classModel)
                print("热门内容 -- 加载网络成功:",classModel)
            case let .error( error):
                print("error:",error)
            case .completed: break
            }
        }).disposed(by: disposeBag)
    }
    // 内容列表
    func requestHotListSource(_ page: Int, per_page: Int, sort: Int) {
        listProvider.rx.request(.requestHotProductList(10, per_page: per_page, start_date: "2020-03-16", end_date: "2020-03-20", sort: sort)).asObservable().mapHandyJsonArray(ProductsModel.self).subscribe({ [weak self] (event) in
            switch event {
            case let  .next(classModel):
                if page == 1 {
                    self?.hotListSource.accept(classModel)
                }else{
                    self?.hotListSource.accept((self?.hotListSource.value)! + classModel)
                }
                print("内容列表 -- 加载网络成功:",classModel)
            case let .error( error):
                print("error:",error)
            case .completed: break
            }
        }).disposed(by: disposeBag)
    }
}


//MARK: -  网络请求：使用HandyJSON 示例
//    func getHotBannerList(_ limit: Int) {
//        provider.rx.request(.getHPPropagandize(limit)).asObservable().mapHandyJsonModel(ActivityModel.self).subscribe({ [unowned self] (event) in
//
//            switch event {
//            case let  .next(classModel):
//
//                print("HandyJSON -- 加载网络成功")
//
//            case let .error( error):
//                print("error:", error)
//               self.networkError.accept(error as! Error.Protocol)
//            case .completed: break
//            }
//        }).disposed(by: self.disposeBag)
//    }
