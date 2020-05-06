//
//  HYLBaseModel.swift
//  DaNeng
//
//  Created by Fexerlear on 2018/9/25.
//  Copyright © 2018年 Mac. All rights reserved.
//
// 基础模型，存放通用模型

import Foundation
import ObjectMapper


class BaseModel: Mappable {
    var status = 0
    var msg = ""
    
    var is_update = false
    var updateMsg = ""

    required init?(map: Map) { }
    
    func mapping(map: Map) {
        msg <- map["msg"]
        status <- map["status"]
        is_update <- map["data.is_update"]
        updateMsg <- map["data.msg"]

    }
}
