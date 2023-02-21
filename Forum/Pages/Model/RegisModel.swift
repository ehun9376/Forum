//
//  RegisModel.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/21.
//

import Foundation

class RegisModel: NSObject {
    
    var account: String?
    
    var password: String?
    
    var name: String?
    
    var address: String?
    
    var birthday: String?
    
    init(
        account: String? = nil,
        password: String? = nil,
        name: String? = nil,
        address: String? = nil,
        birthday: String? = nil
    ) {
        self.account = account
        self.password = password
        self.name = name
        self.address = address
        self.birthday = birthday
    }
    
    func clean() {
        self.account = nil
        self.password = nil
        self.name = nil
        self.address = nil
        self.birthday = nil
    }
    
}
