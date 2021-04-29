//
//  StringExtension.swift
//  Challenge
//
//  Created by ice on 2020/3/12.
//  Copyright © 2020 ice. All rights reserved.
//

import Foundation

// 扩展方法
extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
