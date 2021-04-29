//
//  NewestViewModel.swift
//  Challenge
//
//  Created by ice on 2020/3/17.
//  Copyright © 2020 ice. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxCocoa

class NewestViewModel {
    private let provider = MoyaProvider<ProductApi>()
    let disposeBag = DisposeBag()
    var dataSource = BehaviorRelay<[ProductsModel]>(value: [])
    var networkError = BehaviorRelay(value: MoyaError.self)
}

// MARK: - 网络请求
extension NewestViewModel {
    //MARK: - 内容列表
    func requestNewestContent(_ page: Int, per_page: Int, sort: Int) {
        provider.rx.request(.requestHotProductList(10, per_page: 10, start_date: "2020-03-16", end_date: "2020-03-20", sort: 5)).asObservable().mapHandyJsonArray(ProductsModel.self).subscribe({ [weak self] (event) in
            switch event {
            case let  .next(classModel):
                if page == 1 {
                    self?.dataSource.accept(classModel)
                }else {
                    self?.dataSource.accept((self?.dataSource.value)! + classModel)
                }
                print("newest -- 加载网络成功:",classModel)
            case let .error( error):
                print("error:",error)
            case .completed: break
            }
        }).disposed(by: disposeBag)
    }
}
