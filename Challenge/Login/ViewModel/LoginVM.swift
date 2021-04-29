//
//  LoginVM.swift
//  Challenge
//
//  Created by ice on 2020/3/20.
//  Copyright © 2020 ice. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class LoginVM: NSObject {
    private let provider = MoyaProvider<AppLoginApi>()
    func sendMessage(telNum:String) -> Observable<String> {
        return Observable<String>.create ({ observable in
            self.provider.request(.getVerifyCode, callbackQueue: DispatchQueue.main){ response in
                switch response {
                case .success(_):
                    observable.onNext("true")
                    observable.onCompleted()
                case let .failure(error):
                    observable.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    
    func loginApp(telNum:String,verifyCode:String) -> Observable<UserInfoModel> {
        return Observable<UserInfoModel>.create({ observable in
            self.provider.request(.getUserInfoLoginApi(phone_number: "13956954028", sms_code: "123456"), callbackQueue: DispatchQueue.main){ response in
                switch response {
                case .success(_):
                    
                    /// 暂时先这么写，项目停了，到此为止先
                    let userInfoModel = UserInfoModel.init()
                    observable.onNext(userInfoModel)
                    observable.onCompleted()
                case let .failure(error):
                    observable.onError(error)
                }
            }
            return Disposables.create()
        })
    }
}
