//
//  ControllerExtension.swift
//  DaNeng
//
//  Created by Mac on 2018/1/14.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

internal extension UIViewController {
/**
 * 给模态方式跳转后的控制器加一个导航栏，因为是模态跳转，所以后面的导航栏和前面的导航栏（如果有的
 * 话）没有任何联系。
 */
    func presentControllerAddNavigation_CN(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        let nav = UINavigationController(rootViewController: viewController)
        self.present(nav, animated: animated, completion: completion)
    }
}
