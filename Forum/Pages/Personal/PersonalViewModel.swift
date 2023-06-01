//
//  PersonalViewModel.swift
//  Forum
//
//  Created by yihuang on 2023/6/1.
//

import Foundation

protocol PersonalViewMethod {
}

class PersonalViewModel: NSObject {
    
    var delegate: PersonalViewMethod?
    
    var adapter: TableViewAdapter?
    
    var account: String?
    
    var regisModel: RegisModel?
    
    var newsModels: NewsListModel?
    
    init(delegate: PersonalViewMethod? = nil, adapter: TableViewAdapter? = nil) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    func setupRowModel() {
        
        var rowModels: [CellRowModel] = []
        
        let param = [
            "account": self.account ?? ""
        ]

        APIService.shared.requestWithParam(urlText: .getPersonalInfo, params: param, modelType: RegisModel.self) { jsonModel, error in

            if let error = error {
                print(error.localizedDescription)
            }

            if let jsonModel = jsonModel {
                self.regisModel = jsonModel
                if let regisModel = self.regisModel {
                    let rowModel = HeadCellRowModel(headImageURLText: nil, title: regisModel.name, account: regisModel.account, birthday: regisModel.birthday, cellDidSelect: nil)
                    rowModels.append(rowModel)
                }
                self.adapter?.updateTableViewData(rowModels: rowModels)
                
                APIService.shared.requestWithParam(urlText: .getPersonalPost, params: param, modelType: NewsListModel.self) { jsonModel, error in
                    if let jsonModel = jsonModel {
                        for model in jsonModel.listModel.reversed() {
                            rowModels.append(self.creatNewsRowModel(newsModel: model))
                        }
                        self.adapter?.updateTableViewData(rowModels: rowModels)
                        
                    }
                    
                }
                
            }
        }
//
//        if LocalTestCenter.shared.isLocalTest {
//            for model in LocalTestCenter.shared.newsModels.reversed() {
//                rowModels.append(self.creatNewsRowModel(newsModel: model))
//            }
//            self.adapter?.updateTableViewData(rowModels: rowModels)
//        } else {
//            APIService.shared.requestWithParam(urlText: .getAllPost, params: [:], modelType: NewsListModel.self) { jsonModel, error in
//
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//
//                if let jsonModel = jsonModel, jsonModel.success {
//                    for model in jsonModel.listModel.reversed() {
//                        rowModels.append(self.creatNewsRowModel(newsModel: model))
//                    }
//                    self.adapter?.updateTableViewData(rowModels: rowModels)
//                } else {
//                    print(jsonModel?.message ?? "")
//                }
//            }
//        }

        
       
        
    }
    
    func creatNewsRowModel(newsModel: NewsModel) -> CellRowModel {
        
        let rowModel = NewsCellRowModel(name: newsModel.account,
                                        date: newsModel.date,
                                        headImageURL: nil,
                                        content: newsModel.content,
                                        nameLabelAction: nil,
                                        heightChangeAction: { [weak self] in
            self?.adapter?.tableView?.beginUpdates()
            self?.adapter?.tableView?.endUpdates()
        })
                                                
        
        return rowModel
    }
    
    func createHeadRowModel() -> CellRowModel {
        let rowModel = HeadCellRowModel(headImageURLText: nil)
        
        return rowModel
    }

}
