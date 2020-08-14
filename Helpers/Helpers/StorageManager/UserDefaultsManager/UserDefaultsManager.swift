//
//  UserDefaultsManager.swift
//  TestSwift
//
//  Created by Salim MAALOUF-EXT on 7/27/18.
//  Copyright © 2018 Salim MAALOUF-EXT. All rights reserved.
//

import UIKit

public class UserDefaultsManager: NSObject {
    
    static var defaults = UserDefaults.standard
    
    // Bool
    public static func setBool(bool: Bool, forKey: String) {
        defaults.set(bool, forKey: forKey)
    }
    
    public static func getBool(forKey: String) -> Bool {
        return defaults.bool(forKey: forKey)
    }
    
    // Int
    public static func setInt(int: Int, forKey: String) {
        defaults.set(int, forKey: forKey)
    }
    
    public static func getInt(forKey: String) -> Int {
        return defaults.integer(forKey: forKey)
    }
    
    // Float
    public static func setFloat(float: Float, forKey: String) {
        defaults.set(float, forKey: forKey)
    }
    
    public static func getFloat(forKey: String) -> Float {
        return defaults.float(forKey: forKey)
    }
    
    // Double
    public static func setDouble(double: Double, forKey: String) {
        defaults.set(double, forKey: forKey)
    }
    
    public static func getDouble(forKey: String) -> Double {
        return defaults.double(forKey: forKey)
    }
    
    // NSURL
    public static func setURL(url: NSURL, forKey: String) {
        defaults.set(url, forKey: forKey)
    }
    
    public static func getURL(forKey: String) -> NSURL {
        return defaults.url(forKey: forKey)! as NSURL
    }
    
    // String
    public static func setString(str: String, forKey: String) {
        defaults.set(str, forKey: forKey)
    }
    
    public static func getString(forKey: String) -> String {
        return defaults.string(forKey: forKey)!
    }
    
    // Object
    public static func setObject(object: Any?, forKey: String) {
        defaults.set(object, forKey: forKey)
    }
    
    public static func getObject(forKey: String) -> Any? {
        return defaults.object(forKey: forKey)
    }
    
    // Remove object
    public static func removeObject(forKey: String) {
        defaults.removeObject(forKey: forKey)
    }
    
    // Remove all objects
    public static func removeAllObject() {
        let dict = defaults.dictionaryRepresentation()
        dict.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
}
