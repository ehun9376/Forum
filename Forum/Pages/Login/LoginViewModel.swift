//
//  LoginViewModel.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/21.
//

import Foundation


protocol LoginMethod {
    
    func loginComplete(success: Bool)
    func regisButtonAction()
}

class LoginViewModel: NSObject {
    
    var delegate: LoginMethod?
    
    var adapter: TableViewAdapter?
    
    var loginModel: RegisModel = .init()
    
    init(delegate: LoginMethod? = nil, adapter: TableViewAdapter? = nil) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    func setupRowModel() {
        var rowModels: [CellRowModel] = []
        
        rowModels.append(contentsOf: self.creatRowModels())
        rowModels.append(self.createTwoButtonRowModel())
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
    }
    
    func creatRowModels() -> [CellRowModel] {
        
        var rowModels: [CellRowModel] = []
        
        let accountRow = TitleTextFieldCellRowModel(title: "帳號:",
                                                    placeHolder: "輸入您的帳號",
                                                    didEditAction: { [weak self] text in
            self?.loginModel.account = text
        })
        
        rowModels.append(accountRow)
        
        let passwordRow = TitleTextFieldCellRowModel(title: "密碼:",
                                                    placeHolder: "輸入您的密碼",
                                                    didEditAction: { [weak self] text in
            self?.loginModel.password = text
        })
        
        rowModels.append(passwordRow)
        
        return rowModels
    }
    
    func createTwoButtonRowModel() -> CellRowModel {
        let twoButtonRow = TwoButtonCellRowModel(rightButtonTitle: "登入",
                                                 leftButtonTitle: "註冊",
                                                 rightButtonAction: { [weak self] in
            LoginCenter().login(account: self?.loginModel.account ?? "",
                                password: self?.loginModel.password ?? "",
                                complete: { [weak self] success in
                self?.delegate?.loginComplete(success: success)
            })
        },
                                                 leftButtonAction: { [weak self] in
            self?.delegate?.regisButtonAction()
        })
        
        return twoButtonRow
    }
    
    

}
