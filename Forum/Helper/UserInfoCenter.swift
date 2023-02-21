//
//  UserDefaultCenter.swift
//  BlackSreenVideo
//
//  Created by yihuang on 2022/11/23.
//

import Foundation
import UIKit



class UserInfoCenter: NSObject {
    
    static let shared = UserInfoCenter()
    
    enum UserInfoDataType: String {
        case userAccount
        case userPassword
        case userName
    }
    
    func storeValue(_ type: UserInfoDataType, data: Any?) {
        UserDefaults.standard.set(data, forKey: type.rawValue)
    }
    
    func loadValue(_ type: UserInfoDataType) -> Any? {
        if let something = UserDefaults.standard.object(forKey: type.rawValue) {
            return something
        } else {
            return nil
        }
    }
    
    func cleanValue(_ type: UserInfoDataType) {
        UserDefaults.standard.removeObject(forKey: type.rawValue)
    }
}
