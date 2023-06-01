//
//  PersonalViewController.swift
//  Forum
//
//  Created by yihuang on 2023/6/1.
//

import Foundation
import UIKit

class PersonalViewController: BaseTableViewController {
    
    var viewModel: PersonalViewModel?
    
    var account: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBarAppearance(color: .white)
                
        self.regisCellID(cellIDs: [
            "NewsCell",
            "HeadCell"
        ])
        
        self.viewModel = .init(delegate: self, adapter: .init(self.defaultTableView))
        
        self.viewModel?.account = account
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.setupRowModel()
    }

}

extension PersonalViewController: PersonalViewMethod {

}
