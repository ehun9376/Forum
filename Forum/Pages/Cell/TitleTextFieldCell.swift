//
//  TitleTextFieldCell.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/21.
//

import Foundation
import UIKit

class TitleTextFieldCellRowModel: CellRowModel {
    override func cellReUseID() -> String {
        return "TitleTextFieldCell"
    }
    
    var title: String?
    
    var content: String?
    
    var placeHolder: String?
    
    var didEditAction: ((String)->())?
    
    init(title: String? = nil,
         content: String? = nil,
         placeHolder: String?,
         didEditAction: ((String)->())?) {
        self.title = title
        self.content = content
        self.placeHolder = placeHolder
        self.didEditAction = didEditAction
    }
}

class TitleTextFieldCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentTExtField: UITextField!
    
    var rowModel: TitleTextFieldCellRowModel?
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        
        self.contentTExtField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.rowModel?.didEditAction?(textField.text ?? "")
        print(textField.text ?? "")
    }
}


extension TitleTextFieldCell: CellBinding {

    
    func setupCellView(model: CellModelBase) {
        guard let rowModel = model as? TitleTextFieldCellRowModel else { return }
        self.rowModel = rowModel
        self.titleLabel.text = rowModel.title
        self.contentTExtField.text = rowModel.content
    }
    
    
}
