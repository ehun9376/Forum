//
//  LocalTestCenter.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/21.
//

import Foundation

class LocalTestCenter: NSObject {
    
    static let shared = LocalTestCenter()
    
    var isLocalTest: Bool = true
    
    var newsModels: [NewsModel] = []
    
    var regisModel: [RegisModel] = []
    
}
