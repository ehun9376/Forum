//
//  TwoButtonCell.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/21.
//

import Foundation
import UIKit

class TwoButtonCellRowModel: CellRowModel {
    override func cellReUseID() -> String {
        return "TwoButtonCell"
    }
    
    var rightButtonTitle: String?
    
    var leftButtonTitle: String?
    
    var rightButtonAction: (()->())?
    
    var leftButtonAction: (()->())?
    
    init(rightButtonTitle: String? = nil, leftButtonTitle: String? = nil, rightButtonAction: (() -> Void)? = nil, leftButtonAction: (() -> Void)? = nil) {
        self.rightButtonTitle = rightButtonTitle
        self.leftButtonTitle = leftButtonTitle
        self.rightButtonAction = rightButtonAction
        self.leftButtonAction = leftButtonAction
    }
}

class TwoButtonCell: UITableViewCell {
    
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var leftButton: UIButton!
    
    var rowModel: TwoButtonCellRowModel?
    
    override  func awakeFromNib() {
        self.selectionStyle = .none
        
        self.rightButton.setTitleColor(.blue, for: .normal)
        self.rightButton.layer.borderColor = UIColor.blue.cgColor
        self.rightButton.layer.borderWidth = 1
        self.rightButton.layer.cornerRadius = 5
        self.rightButton.clipsToBounds = true
        self.rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        
        self.leftButton.setTitleColor(.gray, for: .normal)
        self.leftButton.layer.borderColor = UIColor.gray.cgColor
        self.leftButton.layer.borderWidth = 1
        self.leftButton.layer.cornerRadius = 5
        self.leftButton.clipsToBounds = true
        self.leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
    }
    
    @objc func rightButtonAction() {
        self.rowModel?.rightButtonAction?()
    }
    
    @objc func leftButtonAction() {
        self.rowModel?.leftButtonAction?()
    }
    
}

extension TwoButtonCell: CellBinding {

    func setupCellView(model: CellModelBase) {
        guard let rowModel = model as? TwoButtonCellRowModel else { return }
        
        self.rowModel = rowModel
        self.rightButton.setTitle(rowModel.rightButtonTitle, for: .normal)
        self.leftButton.setTitle(rowModel.leftButtonTitle, for: .normal)
        
    }
}
