//
//  AddNewsViewController.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/20.
//

import Foundation
import UIKit

class AddNewsViewController: BaseViewController {
    
    let placeHolderTextView = PlaceHolderTextView(placeHolderText: "請輸入內容")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "新增貼文"
        self.addTextView()
        self.setupRightItem()
    }
    
    func addTextView() {
        
        self.view.addSubview(self.placeHolderTextView)
        
        NSLayoutConstraint.activate([
            self.placeHolderTextView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.placeHolderTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.placeHolderTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.placeHolderTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
    }
    
    func setupRightItem() {
        self.navigationItem.rightBarButtonItem = .init(title: "送出", style: .done, target: self, action: #selector(rightItemAction))
    }
    
    @objc func rightItemAction() {
        self.view.endEditing(true)
        guard let text = self.placeHolderTextView.text, text != "" else {
            self.showSingleAlert(title: "提示", message: "不能送空的訊息喔~")
            return
        }
        self.showAlert(title: "提示",
                       message: "確定要送出了嗎?",
                       confirmAction: { [weak self] in
            self?.sendNewsAPI(content: text)
        },
                       cancelAction: nil)
    }
    
    func sendNewsAPI(content: String = "") {
        //TODO: - 接上ＡＰＩ
        print(content)
        
        if LocalTestCenter.shared.isLocalTest {
            let model = NewsModel(account: UserInfoCenter.shared.loadValue(.userAccount) as? String ?? "",
                                  name: UserInfoCenter.shared.loadValue(.userName) as? String ?? "",
                                  content: content,
                                  date: Date().toString())
            LocalTestCenter.shared.newsModels.append(model)
        } else {
            
        }
        
        self.showToast(message: "已送出", complete: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
        
    }
    
}

