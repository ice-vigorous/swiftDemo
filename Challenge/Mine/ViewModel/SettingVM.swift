//
//  SettingVM.swift
//  Challenge
//
//  Created by ice on 2020/3/18.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import RxSwift

class SettingVM: NSObject {
    var dataArray = [MineFunctionCellModel]()
    var originalT = ["个人资料","版本号","免责声明","隐私条款"]
    var originalD = ["","1.0.1","","",""]
    func getDataArray() -> Observable<[MineFunctionCellModel]> {
        for index in 0..<4 {
            let modelItem = MineFunctionCellModel.init(title: originalT[index], subDesc: originalD[index])
            dataArray.append(modelItem)
        }
        return Observable.just(dataArray)
    }
}
