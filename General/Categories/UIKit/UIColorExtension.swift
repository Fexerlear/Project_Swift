//
//  YLUIColorExtension.swift
//  DaNeng
//
//  Created by Fexerlear on 2019/2/21.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Hue
/// hex颜色
public struct HexColor {

    /// 主背景色 f5f5f5
    public let APP_VIEW_BACKGROUNDCOLOR = UIColor(hexString: "#f5f5f5")
    /// 主色调蓝色
    public let APP_COLOR_MAIN = UIColor(hexString: "#0e80fd")
    /// 确认提交按钮的颜色
    public let BTN_COLOR_Confirm = UIColor(hexString: "#0e80fd")
    public let Bottom_slider_Color = UIColor(hexString: "#0e80fd")
    // 常用色号
    public let Color_0E80FD = UIColor(hexString: "#0e80fd")
    public let Color_333333 = UIColor(hexString: "#333333")
    public let Color_666666 = UIColor(hexString: "#666666")
    public let Color_323232 = UIColor(hexString: "#323232")
    public let Color_eeeeee = UIColor(hexString: "#eeeeee")
    public let Color_999999 = UIColor(hexString: "#999999")
    public let Color_222222 = UIColor(hexString: "#222222")
    
}

extension UIColor {

    convenience init(hexString: String) {
        self.init(hex: hexString)

    }
    
}

