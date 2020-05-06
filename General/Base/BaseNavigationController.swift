//
//  BaseNavigationController.swift
//  DaNeng
//
//  Created by Mac on 2018/1/21.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

/***
 * 暂时只给了LoginWithPwdController使用；其余的页面的导航的设置交给了统一的视图控制器BaseController进行了设置。
 *
 */

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 去除导航栏下黑线
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.hidesNavigationBarHairline = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = HexColor().APP_COLOR_MAIN
        self.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
