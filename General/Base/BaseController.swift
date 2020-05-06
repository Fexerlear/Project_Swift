//
//  BaseController.swift
//  DaNeng
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

internal class BaseController: UIViewController {
    // leftBarBtn
    lazy var leftBarBtn: UIBarButtonItem = {
        let barBtn = UIBarButtonItem(image: UIImage(named: "BackForAllVc"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.pop))
        return barBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = leftBarBtn
        // 隐藏黑线设置无蒙版效果
//        self.navigationController?.hidesNavigationBarHairline = true
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        self.view.backgroundColor = HexColor().APP_VIEW_BACKGROUNDCOLOR
        

    }
    
    /// 设置导航栏样式 style 1:白底黑字(默认)  2，蓝底白字
    func setNavigationControllerStyle(style: Int) {
        var bgColor = UIColor.white
        var titleColor = UIColor(hexString: "323232")
        var barStyle = UIBarStyle.black
        if style == 2 {
            bgColor = HexColor().APP_COLOR_MAIN
            titleColor = UIColor.white
            barStyle = UIBarStyle.default
        }
        
        
        self.navigationController?.navigationBar.barStyle = barStyle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
        self.navigationController?.navigationBar.tintColor = titleColor
        self.navigationController?.navigationBar.barTintColor = bgColor
    }
    
    // MARK: - Events
    @objc func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // 跳转到指定页面
    @objc func pushToVC(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    

}
