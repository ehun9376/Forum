//
//  LocalTestCenter.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/21.
//

import Foundation

class LocalTestCenter: NSObject {
    
    static let shared = LocalTestCenter()
    
    var times: Int {
        get {
            return UserInfoCenter.shared.loadValue(.iaped) as? Int ?? 3
        }
        set {
            UserInfoCenter.shared.storeValue(.iaped, data: newValue)
        }
    }
    
    var newsModels: [NewsModel] {
        get {
            return UserInfoCenter.shared.loadData(modelType: [NewsModel].self, .history) ?? []
        }
        set {
            UserInfoCenter.shared.storeData(model: newValue, .history)
        }
    }
    
    
}
