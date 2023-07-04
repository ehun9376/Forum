//
//  LanchViewController.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/20.
//

import Foundation
import UIKit

class LanchViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO: 接後台內購API
        IAPCenter.shared.requestComplete = { [weak self] debug in
            DispatchQueue.main.async {
                self?.firstWindows?.rootViewController = UINavigationController(rootViewController: ListViewController())
            }
        }
        
        IAPCenter.shared.getProducts()
        


    }

}
