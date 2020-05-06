//
//  NJLog_CN.swift
//  DaNeng
//
//  Created by Mac on 2018/1/25.
//  Copyright © 2018年 Mac. All rights reserved.
//

import Foundation

internal func NJLog<T>(message: T, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    #if DEBUG
        print("\n\n\n当前文件：\((fileName as NSString).lastPathComponent)\n[\(lineNumber)行]打印方法：\(methodName)\n输出信息：\(message)")
    #endif
}
