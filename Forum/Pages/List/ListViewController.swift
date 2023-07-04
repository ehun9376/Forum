//
//  ViewController.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/16.
//

import UIKit

class ListViewController: BaseTableViewController {
    
    var viewModel: ListViewModel?
    
    var addNewsButton = FloatingButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBarAppearance(color: .white)
        
        self.resetTableView()
        self.setupFloatButton()
        self.setupRightItem()
        
        self.regisCellID(cellIDs: [
            "NewsCell",
            "HeadCell"
        ])
        
        self.viewModel = .init(delegate: self, adapter: .init(self.defaultTableView))
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.setupRowModel()
        self.setupRightItem()
        
    }
    
    
    func resetTableView() {
        self.defaultTableView.removeFromSuperview()
        self.defaultTableView.separatorStyle = .none
        self.defaultTableView.backgroundColor = .lightGray
        
        self.view.backgroundColor = .lightGray
        
        self.view.addSubview(self.defaultTableView)
        
        NSLayoutConstraint.activate([
            self.defaultTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.defaultTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.defaultTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.defaultTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
    
    func setupFloatButton() {
        self.addNewsButton = .init(action: { [weak self] in
            self?.addNews()
        })
        self.view.addSubview(self.addNewsButton)
        NSLayoutConstraint.activate([
            self.addNewsButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
            self.addNewsButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30)
        ])
    }
    
    func addNews() {
        let vc = AddNewsViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupRightItem() {
        self.navigationItem.rightBarButtonItem = .init(title: "設定", style: .done, target: self, action: #selector(rightItemAction))
    }
    
    @objc func rightItemAction() {
        
        let loginVC = SettingViewController()
        self.navigationController?.pushViewController(loginVC, animated: true)

        
    }


}

extension ListViewController: ListViewMethod {

    func addNewsRowDidSelect() {
        self.addNews()
    }
}
