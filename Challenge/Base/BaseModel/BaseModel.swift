//
//  BaseModel.swift
//  Challenge
//
//  Created by ice on 2020/3/11.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import HandyJSON

class BaseModel: HandyJSON {
    // 父类实现此方法，子类无需实现。
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        // 自定义解析规则，如果要指定解析格式，子类实现重写此方法即可。
    }
}
