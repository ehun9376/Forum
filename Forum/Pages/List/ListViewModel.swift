//
//  ListViewModel.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/16.
//

import Foundation

protocol ListViewMethod {
    func nameButtonPressed(model: NewsModel)
}

class ListViewModel: NSObject {
    
    var delegate: ListViewMethod?
    
    var adapter: TableViewAdapter?
    
    init(delegate: ListViewMethod? = nil, adapter: TableViewAdapter? = nil) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    func setupRowModel() {
        var rowModels: [CellRowModel] = []

        if LocalTestCenter.shared.isLocalTest {
            for model in LocalTestCenter.shared.newsModels.reversed() {
                rowModels.append(self.creatNewsRowModel(newsModel: model))
            }
            self.adapter?.updateTableViewData(rowModels: rowModels)
        } else {
            APIService.shared.requestWithParam(urlText: .getAllPost, params: [:], modelType: NewsListModel.self) { jsonModel, error in
                
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let jsonModel = jsonModel, jsonModel.success {
                    for model in jsonModel.listModel.reversed() {
                        rowModels.append(self.creatNewsRowModel(newsModel: model))
                    }
                    self.adapter?.updateTableViewData(rowModels: rowModels)
                } else {
                    print(jsonModel?.message ?? "")
                }
            }
        }

        
       
        
    }
    
    func creatNewsRowModel(newsModel: NewsModel) -> CellRowModel {
        
        let rowModel = NewsCellRowModel(name: newsModel.account,
                                        date: newsModel.date,
                                        headImageURL: nil,
                                        content: newsModel.content,
                                        nameLabelAction: { [weak self]  in
            self?.delegate?.nameButtonPressed(model: newsModel)
        },
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
