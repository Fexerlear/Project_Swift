//
//  UITableView+Ext.swift
//  DaNeng
//
//  Created by Fexerlear on 2019/1/31.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

public extension String {
    /// 获取Nib文件路径
       var nibPath: String? {
           return Bundle.main.path(forResource: self, ofType: "nib")
       }
       /// 创建Nib文件
       var nib: UINib? {
           return UINib.init(nibName: self, bundle: nil)
       }
}


public extension UITableView {
    
    //MARK: 隐藏多余的线
    /// 隐藏多余的线
    func k_hiddeLine() {
        
        self.tableFooterView = UIView()
    }
    
    //MARK: 注册单元格 使用类名作为标记符
    /// 注册单元格 使用类名作为标记符
    ///
    /// - Parameter cls: 单元格
    func k_registerCell(cls: AnyClass) {
        let clsName: String = "\(cls)"
        if clsName.nibPath != nil {
            self.register(clsName.nib, forCellReuseIdentifier: clsName)
        } else {
            self.register(cls, forCellReuseIdentifier: clsName)
        }
    }
    /// 获取注册的单元格
    ///
    /// - Parameters:
    ///   - cls: 类名
    ///   - indexPath: indexPath
    func k_dequeueReusableCell <T> (cls: T.Type, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: "\(cls)", for: indexPath) as? T else {
            fatalError("出错了,请检查单元格注册方法")
        }
        return cell
    }
}

public extension UICollectionView {
    
    //MARK: 注册单元格 使用类名作为标记符
    /// 注册单元格 使用类名作为标记符
    ///
    /// - Parameter cls: 单元格
    func k_registerCell(cls: AnyClass) {
        let clsName = "\(cls)"
        if clsName.nibPath != nil {
            self.register(clsName.nib, forCellWithReuseIdentifier: clsName)
        } else {
            self.register(cls, forCellWithReuseIdentifier: clsName)
        }
    }
    //MARK: 获取注册的单元格
    /// 获取注册的单元格
    ///
    /// - Parameters:
    ///   - cls: 类名
    ///   - indexPath: indexPath
    func k_dequeueReusableCell <T> (cls: T.Type, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: "\(cls)".components(separatedBy: ".").last!, for: indexPath) as? T else {
            fatalError("出错了,请检查单元格注册方法")
        }
        return cell
    }
    
    /// 注册组头
    ///
    /// - Parameter cls: 组头
    func k_registerHeader(cls: AnyClass) {
        let clsName = "\(cls)"
        if clsName.nibPath != nil {
            self.register(clsName.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: clsName)
        } else {
            self.register(cls, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: clsName)
        }
    }
    
    /// 获取注册的组头
    ///
    /// - Parameters:
    ///   - cls: 组头
    ///   - indexPath: indexPath
    /// - Returns: 组头
    func k_dequeueReusableHeader <T> (cls: T.Type, indexPath: IndexPath) -> T {
        guard let header = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(cls)", for: indexPath) as? T else {
            fatalError("出错了,请检查注册方法")
        }
        return header
    }
    
    /// 注册组尾
    ///
    /// - Parameter cls: 组尾
    func k_registerFooter(cls: AnyClass) {
        let clsName = "\(cls)"
        if clsName.nibPath != nil {
            self.register(clsName.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: clsName)
        } else {
            self.register(cls, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: clsName)
        }
    }
    
    /// 获取注册的组尾
    ///
    /// - Parameters:
    ///   - cls: 组尾
    ///   - indexPath: indexPath
    /// - Returns: 组尾
    func k_dequeueReusableFooter <T> (cls: T.Type, indexPath: IndexPath) -> T {
        guard let footer = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(cls)", for: indexPath) as? T else {
            fatalError("出错了,请检查注册方法")
        }
        return footer
    }
}
