//
//  UITextView+Ext.swift
//  DaNeng
//
//  Created by Fexerlear on 2019/1/31.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

var _dl_LimitMaxLengthKey = "__dl_LimitMaxLengthKey"
extension UITextField {
    var dl_maxLength:Int {
        get {
            return (objc_getAssociatedObject(self, &_dl_LimitMaxLengthKey) as AnyObject).intValue
        }
        set(dl_maxLength) {
            objc_setAssociatedObject(self, &_dl_LimitMaxLengthKey, "\(dl_maxLength)", objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
            if dl_maxLength > 0 {
                self.addTarget(self, action: #selector(_dl_valueChanged(_:)), for: .allEditingEvents)
            } else {
                self.removeTarget(self, action: #selector(_dl_valueChanged(_:)), for: .allEditingEvents)
            }
        }
    }
    @objc fileprivate func _dl_valueChanged(_ textfiled:UITextField) {
        if self.dl_maxLength == 0 {
            return
        }
        let currentLength = (textfiled.text?.count)!
        if currentLength <= self.dl_maxLength {
            return
        }
//        let index = textfiled.text!.characters.index(textfiled.text!.startIndex, offsetBy: Int(self.dl_maxLength))
//        let subString = textfiled.text?.substring(to: index)
        let subString = textfiled.text!.prefix(self.dl_maxLength)
        DispatchQueue.main.async {
            textfiled.text = "\(subString)"
            textfiled.sendActions(for: .editingChanged)
        }
    }
}
