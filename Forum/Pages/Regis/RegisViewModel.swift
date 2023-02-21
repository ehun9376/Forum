//
//  RegisViewModel.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/21.
//

import Foundation


protocol RegisMethod {
    func regisComplete()
    
}

class RegisViewModel: NSObject {
    
    var delegate: RegisMethod?
    
    var adapter: TableViewAdapter?
    
    var regisModel: RegisModel = .init()
    
    init(delegate: RegisMethod? = nil, adapter: TableViewAdapter? = nil) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    func setupRowModel() {
        
        var rowModels: [CellRowModel] = []
    
        rowModels.append(contentsOf: self.creatUserInfoRowModels())
        
        rowModels.append(self.createTwoButtonRowModel())
        
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
    }
    
    func creatUserInfoRowModels() -> [CellRowModel] {
        
        var rowModels: [CellRowModel] = []
        
        let accountRow = TitleTextFieldCellRowModel(title: "帳號:",
                                                    placeHolder: "輸入您的帳號",
                                                    didEditAction: { [weak self] text in
            self?.regisModel.account = text
        })
        
        rowModels.append(accountRow)
        
        let passwordRow = TitleTextFieldCellRowModel(title: "密碼:",
                                                    placeHolder: "輸入您的密碼",
                                                    didEditAction: { [weak self] text in
            self?.regisModel.password = text
        })
        
        rowModels.append(passwordRow)
        
        let nameRow = TitleTextFieldCellRowModel(title: "姓名:",
                                                    placeHolder: "輸入您的姓名",
                                                    didEditAction: { [weak self] text in
            self?.regisModel.name = text
        })
        
        rowModels.append(nameRow)
        
        let addressRow = TitleTextFieldCellRowModel(title: "地址:",
                                                    placeHolder: "輸入您的地址",
                                                    didEditAction: { [weak self] text in
            self?.regisModel.address = text
        })
        
        rowModels.append(addressRow)
        
        let birthdayRow = TitleTextFieldCellRowModel(title: "生日",
                                                    placeHolder: "輸入您的生日",
                                                    didEditAction: { [weak self] text in
            self?.regisModel.birthday = text
        })
        
        rowModels.append(birthdayRow)
        
        return rowModels
        
    }
    
    func createTwoButtonRowModel() -> CellRowModel {
        let twoButtonRow = TwoButtonCellRowModel(rightButtonTitle: "送出",
                                                 leftButtonTitle: "清空重填",
                                                 rightButtonAction: { [weak self] in
            //TODO: -送出的API
            if LocalTestCenter.shared.isLocalTest {
                LocalTestCenter.shared.regisModel.append(self?.regisModel ?? .init())
                self?.delegate?.regisComplete()
            } else {
                
            }
        },
                                                 leftButtonAction: { [weak self] in
            self?.regisModel.clean()
            self?.setupRowModel()
        })
        
        return twoButtonRow
    }
    

}
