//
//  CheckVersionManager.swift
//  DaNeng
//
//  Created by Mac on 2018/3/22.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

class CheckVersionManager: NSObject {
    /// app版本更新检测
    
    class func checkAppUpdate(appId:String) {
        NJLog(message: "检测APP是否需要更新")
    }
    // 更新提示
    class func class_updateRemind(appId:String) {

        let alertC = UIAlertController.init(title: "请更新至最新版本", message: "", preferredStyle: .alert)
        
        let yesAction = UIAlertAction.init(title: "前往更新", style: .default, handler: { (handler) in
            let updateUrl:URL = URL.init(string: "http://itunes.apple.com/app/id" + appId)!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(updateUrl, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(updateUrl)
            }
        })
        alertC.addAction(yesAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertC, animated: true, completion: nil)
    }
    
}

