//
//  MyWorksCellModel.swift
//  Challenge
//
//  Created by ice on 2020/3/17.
//  Copyright © 2020 ice. All rights reserved.
//

import HandyJSON

struct MyWorksCellModel: HandyJSON {
    var ID: String?
    
    var video_duration: String?
    
    var description: String?
    
    var publish_date: String?
    
    var type: String?
    
    var title: String?
    
    var audit_status: String?
    
    var video_url: String?
    
    var video_size: String?
    
    var video_cover: String?
    
    var images: [String]?
    
    var audit_message: String?
    
    var activity: Activity?
    
    var user: User?
}
struct Activity: HandyJSON {
    var ID: String?
    
    var title: String?
    
    var user_number: String?
    
    var hot: String?

}
struct User: HandyJSON {
    var nick_name: String?
    
    var follow: String?
    
    var uid: String?
    
    var headimg: String?

}

