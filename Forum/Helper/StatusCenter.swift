//
//  StatusCenter.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/20.
//

import Foundation


class StatusCenter: NSObject {
    
    static let shared = StatusCenter()
        
    private var isLoginNow: Bool = false
    
    func login() {
        self.isLoginNow = true
    }
    
    func logout() {
        self.isLoginNow = false
    }

    func isLogin() -> Bool {
        return self.isLoginNow
    }
    
}
