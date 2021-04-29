//
//  DetailsViewModel.swift
//  Challenge
//
//  Created by ice on 2020/3/18.
//  Copyright © 2020 ice. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import RxCocoa

class DetailsViewModel {
    private let provider = MoyaProvider<ProductApi>()
    let disposeBag = DisposeBag()
    var dataSource = BehaviorRelay<ProductsModel>(value: ProductsModel())
    var networkError = BehaviorRelay(value: MoyaError.self)
}

extension DetailsViewModel {
    func requestDetails(_ productsID: Int) {
        provider.rx.request(.requestProductDetails(productsID)).asObservable().mapHandyJsonModel(ProductsModel.self).subscribe({ [weak self] (event) in
            switch event {
            case let  .next(classModel):
                self?.dataSource.accept(classModel)
                print("newest -- 加载网络成功:",classModel)
            case let .error( error):
                print("error:",error)
            case .completed: break
            }
        }).disposed(by: disposeBag)
    }
}
