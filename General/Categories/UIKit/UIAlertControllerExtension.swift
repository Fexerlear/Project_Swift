//
//  UITextView+Ext.swift
//  DaNeng
//
//  Created by Fexerlear on 2019/1/31.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit


/// 快速创建弹出框
func showMessage(title: String, message: String, viewController: UIViewController) {
    let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alertVC.addAction(UIAlertAction.init(title: "我知道了", style: .cancel, handler: nil))
    viewController.present(alertVC, animated: true, completion: nil)
}

//用于UIAlertController的文字偏移
var alertExtsubviews : [UIView]?
extension UIAlertController{
    var TJL_titleLabel : UILabel?{
        set{
            
        }
        
        get{
            if TJL_viewArray(root: self.view) != nil {
                return TJL_viewArray(root: self.view)![1] as? UILabel
            }
            return nil
        }
    }
    var TJL_messageLabel : UILabel?{
        set{
            
        }
        
        get{
            
            if TJL_viewArray(root: self.view) != nil {
            
                return TJL_viewArray(root: self.view)![2] as? UILabel
            }
            return nil
        }
    }
    
    
    func TJL_viewArray(root:UIView) -> [UIView]?{
        
        alertExtsubviews = nil
        for item in root.subviews{
            
            if alertExtsubviews != nil {
                break
            }
            
            if item is UILabel{
                alertExtsubviews = root.subviews
                return alertExtsubviews!
            }
            
            TJL_viewArray(root: item)
        }
        
        return alertExtsubviews
    }
    
    
}
