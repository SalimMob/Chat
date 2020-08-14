//
//  KeyedArchiverManager.swift
//  TestSwift
//
//  Created by Salim MAALOUF-EXT on 8/27/18.
//  Copyright © 2018 Salim MAALOUF-EXT. All rights reserved.
//

import UIKit

public class KeyedArchiverManager: NSObject {
    
    public static func saveCodableObject<T: Encodable>(object: T, forKey: String, success: @escaping (Bool) -> (), failure: @escaping (Bool) -> ()) {
        do {
            let encodedData = try JSONEncoder().encode(object)
            var archivedData: Data
            if #available(iOS 12.0, *) {
                do {
                    archivedData = try NSKeyedArchiver.archivedData(withRootObject: encodedData, requiringSecureCoding: false)
                    UserDefaultsManager.setObject(object: archivedData, forKey: forKey)
                    success(true)
                } catch {
                    failure(true)
                }
            } else {
                // handle older versions
                archivedData = NSKeyedArchiver.archivedData(withRootObject: encodedData)
                UserDefaultsManager.setObject(object: archivedData, forKey: forKey)
                success(true)
            }
        } catch {
            failure(true)
        }
    }
    
    public static func loadCodableObject<T: Decodable>(object: T.Type, forKey: String, success: @escaping (T) -> (), failure: @escaping (Bool) -> ()) {
        let savedData = UserDefaultsManager.getObject(forKey: forKey)
        if (savedData != nil) {
            if #available(iOS 12.0, *) {
                do {
                    let unarchivedObject = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData as! Data)
                    success(try JSONDecoder().decode(object, from: unarchivedObject as! Data) as T)
                } catch {
                    failure(true)
                }
            } else {
                // handle older versions
                let unarchivedObject = NSKeyedUnarchiver.unarchiveObject(with: savedData as! Data)
                do {
                    success(try JSONDecoder().decode(object, from: unarchivedObject as! Data) as T)
                } catch {
                    failure(true)
                }
            }
        } else {
            failure(true)
        }
    }
    
    public static func saveNSCodingObject(object: Any, forKey: String) {
        var archivedData: Data
        if #available(iOS 12.0, *) {
            do {
                archivedData = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
                UserDefaultsManager.setObject(object: archivedData, forKey: forKey)
            } catch {
                return
            }
        } else {
            // handle older versions
            archivedData = NSKeyedArchiver.archivedData(withRootObject: object)
            UserDefaultsManager.setObject(object: archivedData, forKey: forKey)
        }
    }
    
    public static func loadNSCodingObject(forKey: String) -> Any? {
        let savedData = UserDefaultsManager.getObject(forKey: forKey)
        if #available(iOS 12.0, *) {
            guard let unarchivedObject = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData as! Data) else { return nil }
            return unarchivedObject
        } else {
            // handle older versions
            let unarchivedObject = NSKeyedUnarchiver.unarchiveObject(with: savedData as! Data)
            return unarchivedObject
        }
    }
}
