//
//  LoginViewController.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/20.
//

import Foundation
import UIKit

class LoginViewController: BaseTableViewController {
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.regisCellID(cellIDs: [
            "TitleTextFieldCell",
            "TwoButtonCell"
        ])
        
        
        self.viewModel = .init(delegate: self, adapter: .init(self.defaultTableView))
        self.viewModel?.setupRowModel()
    }
    
}

extension LoginViewController: LoginMethod {
    func loginComplete(success: Bool) {
        DispatchQueue.main.async {
            if success {
                self.firstWindows?.rootViewController = UINavigationController(rootViewController:  ListViewController())
            } else {
                self.showSingleAlert(title: "帳號密碼錯誤", message: "請再試一次")
            }
        }
    }
    func regisButtonAction() {
        let vc = RegisViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

