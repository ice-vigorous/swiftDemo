//
//  MineFunctionCellVM.swift
//  Challenge
//
//  Created by ice on 2020/3/16.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import RxSwift
class MineFunctionCellVM: NSObject {
    var dataArray = [MineFunctionCellModel]()
    var originalT = ["帮助与反馈","设置"]
    func getDataArray() -> Observable<[MineFunctionCellModel]>{
        for index in 0..<2 {
            let modelItem = MineFunctionCellModel.init(title: originalT[index], subDesc: "")
            dataArray.append(modelItem)
        }
        return Observable.just(dataArray)
    }
}
