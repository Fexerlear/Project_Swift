//
//  UserDefaultsManager_CN.swift
//  DaNeng
//
//  Created by Mac on 2018/1/24.
//  Copyright © 2018年 Mac. All rights reserved.
//

import Foundation

// MARK: - Methods
public extension UserDefaults {

    /// SwifterSwift: get object from UserDefaults by using subscript
    ///
    /// - Parameter key: key in the current user's defaults database.
    subscript(key: String) -> Any? {
        get {
            return object(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }

    /// SwifterSwift: Float from UserDefaults.
    ///
    /// - Parameter forKey: key to find float for.
    /// - Returns: Float object for key (if exists).
    func float(forKey key: String) -> Float? {
        return object(forKey: key) as? Float
    }

    /// SwifterSwift: Date from UserDefaults.
    ///
    /// - Parameter forKey: key to find date for.
    /// - Returns: Date object for key (if exists).
    func date(forKey key: String) -> Date? {
        return object(forKey: key) as? Date
    }

    /// SwifterSwift: Retrieves a Codable object from UserDefaults.
    ///
    /// - Parameters:
    ///   - type: Class that conforms to the Codable protocol.
    ///   - key: Identifier of the object.
    ///   - decoder: Custom JSONDecoder instance. Defaults to `JSONDecoder()`.
    /// - Returns: Codable object for key (if exists).
    func object<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
        guard let data = value(forKey: key) as? Data else { return nil }
        return try? decoder.decode(type.self, from: data)
    }

    /// SwifterSwift: Allows storing of Codable objects to UserDefaults.
    ///
    /// - Parameters:
    ///   - object: Codable object to store.
    ///   - key: Identifier of the object.
    ///   - encoder: Custom JSONEncoder instance. Defaults to `JSONEncoder()`.
    func set<T: Codable>(object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
        let data = try? encoder.encode(object)
        set(data, forKey: key)
    }

}


class UserDefaultsManager_CN {
    
    class func queryData(_ key: String) -> String! {
        let data = UserDefaults.standard.value(forKey: key)
        if !isHaveData(key) {
            return ""
        }
        return data! as? String
    }
    // Int 类型
//    class func queryDataForInt(_ key: String) -> Int! {
//        let data = UserDefaults.standard.value(forKey: key)
//        return data! as! Int
//    }
    
    class func isHaveData(_ key: String) -> Bool {
        let data = UserDefaults.standard.value(forKey: key)
        if data == nil {
            return false
        }
        if ((data as! String).isEmpty) {
            return false
        }
        return true
    }
    
    class func saveData(_ key: String, value: Any?) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    class func removeData(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}
