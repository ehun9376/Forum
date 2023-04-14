//
//  LoginCenter.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/21.
//

import Foundation

class LoginCenter: NSObject {
    

    
    func logout(complete:(()->())?) {
        StatusCenter.shared.logout()
        UserInfoCenter.shared.cleanValue(.userAccount)
        UserInfoCenter.shared.cleanValue(.userPassword)
        UserInfoCenter.shared.cleanValue(.userName)
        complete?()
    }
    
    func login(account: String, password: String, complete: ((Bool)->())?) {
        
        if LocalTestCenter.shared.isLocalTest {
            
            if account == "ehun" && password == "1234" {
                StatusCenter.shared.login()
                UserInfoCenter.shared.storeValue(.userAccount, data: account)
                UserInfoCenter.shared.storeValue(.userPassword, data: password)
                UserInfoCenter.shared.storeValue(.userName, data: "逸煌")
                complete?(true)
                return
            }
            
            for model in LocalTestCenter.shared.regisModel {
                if model.account ?? "" == account && model.password ?? "" == password {
                    StatusCenter.shared.login()
                    UserInfoCenter.shared.storeValue(.userAccount, data: account)
                    UserInfoCenter.shared.storeValue(.userPassword, data: password)
                    UserInfoCenter.shared.storeValue(.userName, data: model.name ?? "")
                    complete?(true)
                    return
                }
            }
            complete?(false)
        } else {
            //TODO: -登入ＡＰＩ
            
//        http://www.yihuang.online/login.php?account=joh123456&password=1234
            
            let param: parameter = [
                "account": account,
                "password": password
            ]
            
            APIService.shared.requestWithParam(urlText: .login, params: param, modelType: DefaultSuccessModel.self) { jsonModel, error in
                if let jsonModel = jsonModel, jsonModel.status {
                    StatusCenter.shared.login()
                    UserInfoCenter.shared.storeValue(.userAccount, data: account)
                    UserInfoCenter.shared.storeValue(.userPassword, data: password)
                    complete?(true)
                } else {
                    complete?(false)
                }

            }

        }

    }
    
    func autoLogin(complete: ((Bool)->())?) {
        
        if let account = UserInfoCenter.shared.loadValue(.userAccount) as? String,
           let password = UserInfoCenter.shared.loadValue(.userPassword) as? String {
            self.login(account: account, password: password) { login in
                complete?(login)
            }
        } else {
            complete?(false)
        }
        
    }
    
}
