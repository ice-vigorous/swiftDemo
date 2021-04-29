//
//  ActivityDetailsViewModel.swift
//  Challenge
//
//  Created by ice on 2020/3/19.
//  Copyright © 2020 ice. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxCocoa

class ActivityDetailsViewModel {
    private let activityProvider = MoyaProvider<ActivityApi>()
    private let productProvider = MoyaProvider<ProductApi>()
    let disposeBag = DisposeBag()
    var activitySource = BehaviorRelay<ActivityModel>(value: ActivityModel(JSONString: "")!)
    var contentSource = BehaviorRelay<[ProductsModel]>(value: [])
    var networkError = BehaviorRelay(value: MoyaError.self)
}

//MARK:- 网络请求
extension ActivityDetailsViewModel {
    func requestActivity(_ activityID: Int) {
        activityProvider.rx.request(.requestHPActivityDetails(activityID)).asObservable().mapObjectModel(ActivityModel.self).subscribe({ [weak self] (event) in
            switch event {
            case let  .next(classModel):
                self?.activitySource.accept(classModel)
                print("活动详情 -- 加载网络成功:",classModel)
            case let .error( error):
                print("error:",error)
            case .completed: break
            }
        }).disposed(by: disposeBag)
    }
    
    func requestActiDetailContent(_ activity_id: Int, page: Int, per_page: Int, sort: Int) {
        productProvider.rx.request(.requestProductList(15, page: 10, per_page: 10, start_date: "2020-03-16", end_date: "2020-03-20", sort: 5)).asObservable().mapHandyJsonArray(ProductsModel.self).subscribe({ [weak self] (event) in
            switch event {
            case let  .next(classModel):
                if page == 1 {
                    self?.contentSource.accept(classModel)
                }else {
                    self?.contentSource.accept((self?.contentSource.value)! + classModel)
                }
                print("活动详情页-热门内容 -- 加载网络成功:",classModel)
            case let .error( error):
                print("error:",error)
            case .completed: break
            }
        }).disposed(by: disposeBag)
    }
}
