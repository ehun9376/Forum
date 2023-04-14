//
//  RegisViewController.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/20.
//

import Foundation

class RegisViewController: BaseTableViewController {
    
    var viewModel: RegisViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "註冊"
        
        self.regisCellID(cellIDs: [
            "TitleTextFieldCell",
            "TwoButtonCell"
        ])
        
        self.viewModel = .init(delegate: self, adapter: .init(self.defaultTableView))
        
        self.viewModel?.setupRowModel()
    }
    
}

extension RegisViewController: RegisMethod {
    func regisComplete(success: Bool, text: String) {
        self.showToast(message: text) { [weak self] in
            if success {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
