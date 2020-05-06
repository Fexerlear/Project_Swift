//
//  MainController.swift
//  DaNeng
//
//  Created by Mac on 2018/3/23.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

class MainController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = HexColor().Color_0E80FD
        self.addChildViewControllers()
//        self.selectedIndex = 1
    }
    private func addChildViewControllers() {
        
        addChildViewController(childControllerName: "HomeTVC", title: "首页", imageName: "Home_TabBar")
        addChildViewController(childControllerName: "ReportTVC", title: "报表", imageName: "Report_TabBar")
        addChildViewController(childControllerName: "MessageTVC", title: "消息", imageName: "Message_TabBar")
        addChildViewController(childControllerName: "MineTVC", title: "我的", imageName: "My_TabBar")

       
        
    }
    
    
   
    
    private func addChildViewController(childControllerName: String?, title: String?, imageName: String?) {
        
        guard let name =  Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else
        {
            return
        }
        var cls: AnyClass? = nil
        if let vcName = childControllerName
        {
            cls = NSClassFromString(name + "." + vcName)
        }
        guard let typeCls = cls as? UIViewController.Type else
        {
            return
        }
        let childController = typeCls.init()
        childController.tabBarItem.title = title
        if imageName != nil {
            childController.tabBarItem.image = UIImage(named: imageName!)
            childController.tabBarItem.selectedImage = UIImage(named: imageName! + "_Highlighted")
        }
        
        let nav = UINavigationController(rootViewController: childController)
        self.addChild(nav)
    }
    

}

