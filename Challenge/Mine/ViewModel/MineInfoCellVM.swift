//
//  MineInfoCellVM.swift
//  Challenge
//
//  Created by ice on 2020/3/16.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import RxSwift
class MineInfoCellVM: NSObject {
    var dataArray = [MineFunctionCellModel]()
    var originalT = ["昵称","ID","签名","性别","生日"]
    var originalD = ["一只小猪","4546456","嘿，你好~","女","1998-11-25"]
    func getDataArray() -> Observable<[MineFunctionCellModel]> {
        for index in 0..<5 {
            let modelItem = MineFunctionCellModel.init(title: originalT[index], subDesc: originalD[index])
            dataArray.append(modelItem)
        }
        return Observable.just(dataArray)
    }
}
