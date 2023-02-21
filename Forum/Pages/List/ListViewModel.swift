//
//  ListViewModel.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/16.
//

import Foundation

protocol ListViewMethod {
    func nameButtonPressed(account: String)
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
            rowModels.append(self.createHeadRowModel())
            for model in LocalTestCenter.shared.newsModels.reversed() {
                rowModels.append(self.creatNewsRowModel(newsModel: model))
            }
        } else {
            
        }

        
        self.adapter?.updateTableViewData(rowModels: rowModels)
        
    }
    
    func creatNewsRowModel(newsModel: NewsModel) -> CellRowModel {
        
        let rowModel = NewsCellRowModel(name: newsModel.name,
                                        date: newsModel.date,
                                        headImageURL: nil,
                                        content: newsModel.content,
                                        account: newsModel.account,
                                        nameLabelAction: { [weak self] account in
            self?.delegate?.nameButtonPressed(account: account)
        })
        
        return rowModel
    }
    
    func createHeadRowModel() -> CellRowModel {
        let rowModel = HeadCellRowModel(headImageURLText: nil)
        
        return rowModel
    }

}
