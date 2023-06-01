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
    
    var freshControll = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBarAppearance(color: .white)
        
        self.resetTableView()
//        self.setupFloatButton()
        self.setupRightItem()
        
        self.regisCellID(cellIDs: [
            "NewsCell",
            "HeadCell"
        ])
        
        self.viewModel = .init(delegate: self, adapter: .init(self.defaultTableView))
        
        self.freshControll.addTarget(self, action: #selector(fresh), for: .valueChanged)
        
        self.defaultTableView.refreshControl = self.freshControll
        
    }
    
    @objc func fresh() {
        self.viewModel?.setupRowModel(complete: {
            DispatchQueue.main.async {
                self.freshControll.endRefreshing()
            }
        })
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
//        self.addNewsButton = .init(action: { [weak self] in
//            self?.addNews()
//        })
//        self.view.addSubview(self.addNewsButton)
//        NSLayoutConstraint.activate([
//            self.addNewsButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30),
//            self.addNewsButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30)
//        ])
    }
    
    func addNews() {
        guard StatusCenter.shared.isLogin() else {
            //TODO: - 去登入頁
            print("沒有登入喔")
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        let vc = AddNewsViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupRightItem() {
        self.navigationItem.rightBarButtonItem = .init(title: StatusCenter.shared.isLogin() ? "登出" : "登入", style: .done, target: self, action: #selector(rightItemAction))
    }
    
    @objc func rightItemAction() {
        
        if StatusCenter.shared.isLogin() {
            self.showAlert(title: "提示",
                           message: "確定要登出嗎",
                           confirmAction: { [weak self] in
                LoginCenter().logout(complete: { [weak self] in
                    self?.showToast(message: "已登出")
                    self?.setupRightItem()
                })
            },
                           cancelAction: nil)
        } else {
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: true)
        }
        
    }


}

extension ListViewController: ListViewMethod {
    func nameButtonPressed(model: NewsModel) {
        let vc = PersonalViewController()
        vc.account = model.account
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func addNewsRowDidSelect() {
        self.addNews()
    }
}
