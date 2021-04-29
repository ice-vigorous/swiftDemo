//
//  MineFunctionCellModel.swift
//  Challenge
//
//  Created by ice on 2020/3/13.
//  Copyright © 2020 ice. All rights reserved.
//

import RxDataSources

struct  MineFunctionCellModel{
    var title: String
    var subDesc: String
}


struct FunctionSections {
    var title :String?
    var items: [MineFunctionCellModel]
    
    
}

extension FunctionSections: SectionModelType{
    typealias Item = MineFunctionCellModel
    init(original: FunctionSections, items: [MineFunctionCellModel]) {
        self = original
        self.items = items
    }

}

