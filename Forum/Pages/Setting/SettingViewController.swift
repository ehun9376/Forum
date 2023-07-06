//
//  SettingViewController.swift
//  GymTimer
//
//  Created by 陳逸煌 on 2023/6/30.
//

import Foundation

class SettingViewController: BaseTableViewController {
    
    var adapter: TableViewAdapter?
    
    var rowModels: [CellRowModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "設定"
        self.navigationController?.navigationBar.backgroundColor = .white
        self.adapter = .init(self.defaultTableView)
        self.regisCellID(cellIDs: [
            "SettingCell"
        ])
        self.setupRow()
 
    }
    
    func setupRow() {
        self.rowModels.removeAll()
        let timesRow = SettingCellRowModel(title: "剩餘次數\(LocalTestCenter.shared.times)次",
                                           imageName: "briefcase",
                                           showSwitch: false,
                                           switchAction: nil)
        self.rowModels.append(timesRow)

        
        for model in IAPCenter.shared.buyTypes {
            let rowModel = SettingCellRowModel(title: model.title,
                                               imageName: "briefcase",
                                               showSwitch: false,
                                               switchAction: nil,
                                               cellDidSelect: { _ in

                if !IAPCenter.shared.buy(id: model.id,
                                         stroeComplete: {
                    self.setupRow()
                }) {
                    self.showToast(message: "取得內購產品資料錯誤")
                }
            })
            self.rowModels.append(rowModel)
        }
        
        let restoreRow = SettingCellRowModel(title: "恢復購買",
                                           imageName: "briefcase",
                                           showSwitch: false,
                                           switchAction: nil,
                                             cellDidSelect: { _ in
            IAPCenter.shared.restore(stroeComplete: {
                self.setupRow()
            })
            
        })
        self.rowModels.append(restoreRow)
        
        
        self.adapter?.updateTableViewData(rowModels: self.rowModels)
        
    }
    

}
