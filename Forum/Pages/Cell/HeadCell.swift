//
//  HeadCell.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/16.
//

import Foundation
import UIKit

class HeadCellRowModel: CellRowModel {
    
    override func cellReUseID() -> String {
        return "HeadCell"
    }
    
    var headImageURLText: String?
    
    var account: String?
    
    var birthday: String?
    
    var title: String?
    
    init(headImageURLText: String? = nil, title: String? = "在想什麼呢" , account: String? = nil, birthday: String? = nil, cellDidSelect: ((CellRowModel)->())? = nil ) {
        super.init()
        self.title = title
        self.account = account
        self.birthday = birthday
        self.cellDidSelect = cellDidSelect
        self.headImageURLText = headImageURLText
    }
    
}

class HeadCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var accountLabel: UILabel!
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .lightGray
        
        self.titleLabel.font = .systemFont(ofSize: 16)
        
        self.accountLabel.font = .systemFont(ofSize: 14)
        
        self.birthdayLabel.font = .systemFont(ofSize: 14)
        
        self.headImageView.layer.cornerRadius = 25
    }
    
}

extension HeadCell: CellBinding {
    
    func setupCellView(model: CellModelBase) {
        guard let rowModel = model as? HeadCellRowModel else { return }
        
        if let account = rowModel.account {
            self.accountLabel.isHidden = false
            self.accountLabel.text = "帳號: \(account)"
        } else {
            self.accountLabel.isHidden = true
        }
        
        if let birthday = rowModel.birthday {
            self.birthdayLabel.isHidden = false
            self.birthdayLabel.text = "生日: \(birthday)"
        } else {
            self.birthdayLabel.isHidden = true
        }
        
        if let title = rowModel.title {
            self.titleLabel.text = title
        }
        
        if let urlText = rowModel.headImageURLText {
            self.headImageView.setImageFromURL(urlText: urlText)
        } else {
            self.headImageView.image = UIImage(named: "pho_default_pic_home")
        }
    }
}
