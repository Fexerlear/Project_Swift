//
//  Array+Ext.swift
//  DaNeng
//
//  Created by Fexerlear on 2019/12/12.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import UIKit

public extension Array {
    
    /// 将Array转成data
    var utf8Encoded_CN_Array: Data {
        NJLog(message: NSKeyedArchiver.archivedData(withRootObject: self))
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}
