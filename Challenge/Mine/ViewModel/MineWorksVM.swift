//
//  MineWorksVM.swift
//  Challenge
//
//  Created by ice on 2020/3/17.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class MineWorksVM: NSObject {
    
    var dataArray = Array<MyWorksCellModel>()
    let cellHeight = (kScreenWidth - 2*kCellLeftMargin)*2/3.0 + 5*kCellTopMargin + 30 + 50
    private let provider = MoyaProvider<MyWorksListApi>()
    func getWorksList(page: Int) -> Observable<[MyWorksCellModel]>{
        return Observable<[MyWorksCellModel]>.create ({ observable in
            self.provider.request(.getMyWorksList(uid: "test123", page: 10, per_page: 10, start_date: "2020-03-16", end_date: "2020-03-20", sort: 5), callbackQueue: DispatchQueue.main) { response in
                switch response {
                case let .success(results):
                    self.dataArray.append(contentsOf: results.mapHandyJsonModelArray(MyWorksCellModel.self))
                    observable.onNext(self.dataArray)
                    observable.onCompleted()
                case let .failure(error):
                    observable.onError(error)
                }
            }
            return Disposables.create()
        })
    }
}
