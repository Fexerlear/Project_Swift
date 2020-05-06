//
//  ViewExtension.swift
//  DaNeng
//
//  Created by Mac on 2018/1/15.
//  Copyright © 2018年 Mac. All rights reserved.
//

import UIKit

internal extension UIView {
/**
 * 给UIView添加点击事件。
 */
    func setTapGesture_CN(target: AnyObject, action: Selector) {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapGesture)
    }
}

internal extension UIImageView {
/**
 * 给UIImageView添加点击事件。
 */
    func setTapGestureForUIImageView_CN(target: AnyObject, action: Selector) {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tapGesture)
    }
}

public extension UIView {
    
    //MARK: 设置为圆形控件
    /// 设置为圆形控件
    func k_setCircleImgV() {
        
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = frame.height / 2.0
        self.clipsToBounds = true
    }
    
    //MARK: 设置圆角
    /// 设置圆角
    ///
    /// - Parameter radius: 圆角数
    func k_setCornerRadius(_ radius: CGFloat) {
        
        self.k_cornerRadius = radius
    }
    
    /// 设置圆角
    var k_cornerRadius: CGFloat! {
        set {
            self.layer.cornerRadius = newValue ?? 0.0
            self.clipsToBounds = true
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    //MARK: 设置边框
    /// 设置边框
    ///
    /// - Parameters:
    ///   - color: 颜色
    ///   - width: 宽度
    func k_setBorder(color: UIColor, width: CGFloat) {
        
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    //MARK: 设置特定的圆角
    /// 设置特定的圆角
    ///
    /// - Parameters:
    ///   - corners: 位置
    ///   - radii: 圆角
    func k_setCorner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        
        let maskPath = UIBezierPath(roundedRect: CGRect.init(x: 0.0, y: 0.0, width: self.bounds.width, height: self.bounds.height), byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = CGRect.init(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: self.bounds.height)
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    //MARK: UIView添加点击事件
    /// UIView添加点击事件
    ///
    /// - Parameters:
    ///   - target: 目标
    ///   - action: 事件
    func k_addTarget(action: Selector) {
        
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: action)
        self.addGestureRecognizer(tap)
    }

    /// UIView添加点击事件
    ///
    /// - Parameter clickAction: 点击回调
    func k_addTarget(_ clickAction: ((UIGestureRecognizer)->Void)?) {
        
        k_setAssociatedObject(key: "k_UIViewClickActionKey", value: clickAction)
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(k_tapAction))
        self.addGestureRecognizer(tap)
    }
    
    /// UIView添加长按事件
    ///
    /// - Parameter clickAction: 点击回调
    func k_addLongPressTarget(_ clickAction: ((UIGestureRecognizer)->Void)?) {
        
        k_setAssociatedObject(key: "k_UIViewClickActionKey", value: clickAction)
        self.isUserInteractionEnabled = true
        let tap = UILongPressGestureRecognizer.init(target: self, action: #selector(k_tapAction))
        tap.minimumPressDuration = 0.5
        self.addGestureRecognizer(tap)
    }
    
    /// UIView点击事件
    @objc func k_tapAction(tap: UIGestureRecognizer) {
        DispatchQueue.main.async {
            (self.k_getAssociatedObject(key: "k_UIViewClickActionKey") as? ((UIGestureRecognizer)->Void))?(tap)
        }
    }
    
    //MARK: 单击移除键盘
    /// 单击移除键盘
    func k_tapDismissKeyboard() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(_tapDismissAction))
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main) { [weak self] (note) in
            
            self?.addGestureRecognizer(tap)
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: OperationQueue.main) { [weak self] (note) in
            
            self?.removeGestureRecognizer(tap)
        }
    }
    @objc func _tapDismissAction() {
        
        self.endEditing(true)
    }
}

public extension UIView {
    
    /// 抖动动画
    func startPeekAnimation() {
        
        self.layer.removeAllAnimations()
        // 抖动动画
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.duration = 0.5
        animation.calculationMode = CAAnimationCalculationMode.cubic
        animation.values = [1.5, 0.8, 1.0, 1.2, 1.0]
        self.layer.add(animation, forKey: "transform.scale")
    }
}

public extension UIView {
    
    /// 弹簧动画
    ///
    /// - Parameters:
    ///   - withDuration: 时长
    ///   - usingSpringWithDamping: 0~1.0 越大月不明显
    ///   - animations: 动画
    ///   - completion: 回调
    static func k_animate(withDuration: TimeInterval, usingSpringWithDamping: CGFloat, animations: (()->Void)?, completion: ((Bool)->Void)? = nil) {
        
        guard let animations = animations else { return }
        UIView.animate(withDuration: withDuration, delay: 0.0, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: 0.0, options: .allowAnimatedContent, animations: animations, completion: completion)
    }
}

// MARK: -截屏当前View,生成图片
public extension UIView {
    
    /// 截屏当前View,生成图片
    func k_snapshotImage() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        self.layer.render(in: context)
        let tempImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tempImage
    }
}

// MARK: -绘制虚线
public extension UIView {
    
    /// 绘制虚线
    ///
    /// - Parameters:
    ///   - lineLength: 线长
    ///   - lineSpacing: 间隔
    ///   - lineColor: 颜色
    func k_drawDashLine(lineLength: Int, lineSpacing: Int, lineColor: UIColor) {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = self.bounds
        // 只要是CALayer这种类型,他的anchorPoint默认都是(0.5,0.5)
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        //shapeLayer.fillColor = UIColor.blue.cgColor
        shapeLayer.strokeColor = lineColor.cgColor
        
        shapeLayer.lineWidth = self.frame.size.height
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0))
        
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
}


extension UIView {
    ///设置顶部边框
    public func addBorderTop(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: frame.width, height: size, color: color)
    }
    /// 设置底部边框
    public func addBorderBottom(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: frame.height - size, width: frame.width, height: size, color: color)
    }
    /// 设置左侧边框
    public func addBorderLeft(size: CGFloat, color: UIColor) {
        addBorderUtility(x: 0, y: 0, width: size, height: frame.height, color: color)
    }
    /// 设置右侧边框
    public func addBorderRight(size: CGFloat, color: UIColor) {
        addBorderUtility(x: frame.width - size, y: 0, width: size, height: frame.height, color: color)
    }

    fileprivate func addBorderUtility(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: x, y: y, width: width, height: height)
        layer.addSublayer(border)
    }

    /// view截图为image
    public func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
