//
//  ButtonExtension.swift
//  DaNeng
//
//  Created by Mac on 2018/1/16.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

internal extension UIButton {
    /**
     * 该方法用于创建 “图片在左，文字在右” 的Button自定义样式：一起设置图片、文字颜色、字号、图片和文字的间
     * 距。虽然这也是button的默认样式，但是默认图片和文字没有间距。
     * 方法中默认提供了间距，可以在使用时再次赋值。
     * UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10) 对于image来说：向着左边操作left取负，向着右边
     * left取正。 对于title来说：向着左边操作left取负，反之left取正。                 (top, left,
     * bottom, right)
     * 对于image和title来说：left为正是往右，为负反之；right为正是往左，为负反之。
     */
    /** Demo
     private let PasswordIcon: UIButton = UIButton.leftImageRightTitle_CN(image_Normal: UIImage(named: "IfSaveAddress")!, title_Normal: "全选", titleColor_Normal: UIColor.init(red: 102/255, green: 102/255, blue: 102/255, alpha: 1), image_Selected: UIImage(named: "IfSaveAddress_Highlighted"), title_Selected: nil, titleColor_Selected: nil, font: UIFont.systemFont(ofSize: 16), titleEdgeInsets: UIEdgeInsetsMake(0, -32, 0, 0), imageEdgeInsets: UIEdgeInsetsMake(0, -42, 0, 0))
     */
    class func leftImageRightTitle_CN(image_Normal: UIImage, title_Normal: String, titleColor_Normal: UIColor, image_Selected: UIImage?, title_Selected: String?, titleColor_Selected: UIColor?, font: UIFont, titleEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0), imageEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)) -> UIButton {
        // normal 状态
        let btn = UIButton()
        btn.setImage(image_Normal, for: .normal)
        btn.setTitle(title_Normal, for: .normal)
        btn.setTitleColor(titleColor_Normal, for: .normal)
        btn.titleLabel?.font = font
        btn.titleEdgeInsets = titleEdgeInsets
        btn.imageEdgeInsets = imageEdgeInsets
        // selected状态时的设置,只有当isSelected为true时才会生效。而isSelected的值需要手动设置。不想使用该属性的话，可以在参数里面都设置为nil。
        btn.setImage(image_Selected, for: .selected)
        btn.setTitle(title_Selected, for: .selected)
        btn.setTitleColor(titleColor_Selected, for: .selected)
        
        //        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        return btn
    }
    
    
}

var kUIButtonTimeIntervalKey: Int = 0
var kUIButtonFirstClickKey: Int = 1
var kUIButtonDelayingKey: Int = 2

extension UIButton {
    
    /// 按钮点击一次的时间间隔
    var k_timeSpan: CGFloat {
        
        set {
            
            objc_setAssociatedObject(self, &kUIButtonTimeIntervalKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if self.isKind(of: UIButton.self) {
                
                // 替换方法
                let originalSel = #selector(UIButton.sendAction(_:to:for:))
                let originalMethod = class_getInstanceMethod(UIButton.self, originalSel)!
                let encoding =  method_getTypeEncoding(originalMethod)
                
                let exchangeSel = #selector(UIButton.k_myMethod(_:to:for:))
                let exchangedMethod = class_getInstanceMethod(UIButton.self, exchangeSel)!
                let exchangeIMP = method_getImplementation(exchangedMethod)
                
                if class_addMethod(UIButton.self, exchangeSel, exchangeIMP, encoding) {
                    
                    class_replaceMethod(UIButton.self, originalSel, exchangeIMP, encoding)
                    
                } else {
                    
                    method_exchangeImplementations(originalMethod, exchangedMethod)
                }
            }
        }
        get { return (objc_getAssociatedObject(self, &kUIButtonTimeIntervalKey) as? CGFloat) ?? 0.0 }
    }
    
    /// 是否是第一次点击,是的话执行,下一次点击延迟
    fileprivate var k_isFirstClick: Bool {
        
        set {
            
            objc_setAssociatedObject(self, &kUIButtonFirstClickKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get { return (objc_getAssociatedObject(self, &kUIButtonFirstClickKey) as? Bool) ?? true }
    }
    /// 是否正在执行延迟操作
    fileprivate var k_isDelaying: Bool {
        
        set {
            
            objc_setAssociatedObject(self, &kUIButtonDelayingKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get { return (objc_getAssociatedObject(self, &kUIButtonDelayingKey) as? Bool) ?? false }
    }
    
    @objc func k_myMethod(_ action: Selector, to: Any, for event: UIControl.Event) {
        
        if self.isKind(of: UIButton.self) {
            
            if self.k_isDelaying { return }
            if self.k_isFirstClick {
                
                self.k_myMethod(action, to: to, for: event)
                self.k_isFirstClick = false
                
            } else {
                
                self.k_isDelaying = true
                DispatchQueue.k_asyncAfterOnMain(dealyTime: Double(self.k_timeSpan)) { [unowned self] in
                    
                    self.k_isDelaying = false
                    self.k_myMethod(action, to: to, for: event)
                }
            }
            
        } else {
            
            self.k_myMethod(action, to: to, for: event)
        }
    }
}

var kUIButtonClickKey: Int = 0

extension UIButton {
    
    //MARK: UIButton添加点击事件
    /// UIButton添加点击事件
    ///
    /// - Parameters:
    ///   - events: 事件
    ///   - block: 回调
    func k_addTarget(events: UIControl.Event = .touchUpInside, block: @escaping()->Void) {
        
        objc_setAssociatedObject(self, &kUIButtonClickKey, block, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.addTarget(self, action: #selector(k_btnAction), for: events)
    }
    @objc func k_btnAction() {
        
        if let block = objc_getAssociatedObject(self, &kUIButtonClickKey) as? ()->Void {
            
            block()
        }
    }
    
    //MARK: 设置特殊的按钮
    /// 设置特殊的按钮
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - title: 文字
    ///   - titlePosition: 文字位置
    ///   - spacing: 文字和图片间隔
    ///   - state: 按钮状态
    func k_setBtn(image: UIImage?, title: String, titlePosition: UIView.ContentMode, spacing: CGFloat = 5.0, state: UIControl.State = .normal) {
        
        self.imageView?.contentMode = .center
        self.setImage(image, for: state)
        
        self.positionLabelRespectToImage(title: title, position: titlePosition, spacing: spacing)
        
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
    }
    
    fileprivate func positionLabelRespectToImage(title: String, position: UIView.ContentMode, spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font ?? UIFont.systemFont(ofSize: 14.0)
        let titleSize = title.size(withAttributes: [NSAttributedString.Key.font: titleFont])
        
        var titleInsets: UIEdgeInsets!
        var imageInsets: UIEdgeInsets!
        
        switch (position){
        case .top:
            
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            
        case .bottom:
            
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
            
        case .left:
            
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -(titleSize.width * 2 + spacing))
            
        case .right:
            
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        default:
            
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}

extension UIButton {
    
    /// 设置选中状态文字颜色
    ///
    /// - Parameters:
    ///   - normolColor: normolColor
    ///   - selectColor: selectColor
    func setTitleColor(normolColor:UIColor,selectColor:UIColor) {
        self.setTitleColor(normolColor, for: .normal)
        self.setTitleColor(selectColor, for: .selected)
    }
    
    /// 设置选择状态和未选中状态的image
    ///
    /// - Parameters:
    ///   - normolImge: normolImge
    ///   - selectImage: selectImage
    func setImage(normolImge:UIImage,selectImage:UIImage) {
        self.setImage(normolImge, for: .normal)
        self.setImage(selectImage, for: .selected)
    }

    /// 设置未选择状态的title和color
    ///
    /// - Parameters:
    ///   - title: title
    ///   - titleColor: color
    func setTitleWithTitleColor(title:String,titleColor:UIColor) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
    }

    /// 设置title&image
    ///
    /// - Parameters:
    ///   - title: title
    ///   - image: image
    func setTitleWithImage(title:String,image:UIImage) {
        setImage(image, for: .normal)
        setTitle(title, for: .normal)
    }
}
