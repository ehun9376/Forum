//
//  LanchViewController.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/20.
//

import Foundation
import UIKit

class LanchViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = UserInfoCenter.shared.loadValue(.userAccount) as? String {
            
            LoginCenter().autoLogin { [weak self] login in
                if login {
                    self?.firstWindows?.rootViewController = UINavigationController(rootViewController: ListViewController())
                } else {
                    self?.showNoAccoundAlert()
                }
            }
            
            self.showToast(message: "自動登入中...")

        } else {
            self.showNoAccoundAlert()
        }

        
    }
    
    func showNoAccoundAlert() {
        self.showAlert(title: "你還沒有帳號喔",
                        message: "趕快註冊一個帳號吧",
                        confirmTitle: "註冊~",
                        cancelTitle: "用用看先!",
                        confirmAction: { [weak self] in
            
            let navigation = UINavigationController()
            navigation.viewControllers = [ListViewController(),LoginViewController(),RegisViewController()]
            
            self?.firstWindows?.rootViewController = navigation
        },
                        cancelAction: { [weak self] in
            self?.firstWindows?.rootViewController = UINavigationController(rootViewController: ListViewController())
        })
    }
    
    
  
    
}
