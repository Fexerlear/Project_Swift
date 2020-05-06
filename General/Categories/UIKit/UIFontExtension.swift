//
//  UIFont_AdjustSize.swift
//  DaNeng
//
//  Created by Mac on 2018/8/24.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit


func getScaleFloat(data: CGFloat) -> CGFloat {
    return data * UIScreen.main.bounds.size.width / 375.0
}

public extension UIFont {
    
    /// 6上面显示的字体
    static func adjustSystemFont(ofSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        let size = getScaleFloat(data: ofSize)
        return UIFont.systemFont(ofSize: size, weight: weight)
    }
    /// 6上面显示的粗体
    static func adjustBoldSystemFont(ofSize: CGFloat) -> UIFont {
        let size = getScaleFloat(data: ofSize)
        return UIFont.boldSystemFont(ofSize: size)
    }
    
}
