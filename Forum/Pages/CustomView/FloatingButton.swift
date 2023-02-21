//
//  FloatingButton.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/20.
//

import Foundation
import UIKit

class FloatingButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(
        action: (()->())?
    ) {
        self.init()
        self.action = action
        self.setupView()
    }
    
    var action: (()->())?
    
    func setupView() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .blue
        self.setTitle("+", for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        self.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 50),
            self.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        self.action?()
    }
  
}
