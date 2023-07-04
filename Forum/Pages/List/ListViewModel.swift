//
//  ListViewModel.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/16.
//

import Foundation

protocol ListViewMethod {
    func addNewsRowDidSelect()
}

class ListViewModel: NSObject {
    
    var delegate: ListViewMethod?
    
    var adapter: TableViewAdapter?
    
    init(delegate: ListViewMethod? = nil, adapter: TableViewAdapter? = nil) {
        self.delegate = delegate
        self.adapter = adapter
    }
    
    func setupRowModel(complete: (()->())? = nil) {
        var rowModels: [CellRowModel] = []
        
        for model in LocalTestCenter.shared.newsModels.reversed() {
            rowModels.append(self.creatNewsRowModel(newsModel: model))
        }
        self.adapter?.updateTableViewData(rowModels: rowModels)

    }
    
    func creatNewsRowModel(newsModel: NewsModel) -> CellRowModel {
        
        let rowModel = NewsCellRowModel(name: newsModel.account,
                                        date: newsModel.date,
                                        headImageURL: nil,
                                        content: newsModel.content,
                                        nameLabelAction: { [weak self]  in
//            self?.delegate?.nameButtonPressed(model: newsModel)
        },
                                        heightChangeAction: { [weak self] in
            self?.adapter?.tableView?.beginUpdates()
            self?.adapter?.tableView?.endUpdates()
        })
                                                
        
        return rowModel
    }
    
    func createHeadRowModel() -> CellRowModel {
        let rowModel = HeadCellRowModel(headImageURLText: nil, cellDidSelect: { row in
            self.delegate?.addNewsRowDidSelect()
        })
        
        return rowModel
    }

}
