//
//  NewsCell.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/16.
//

import Foundation
import UIKit

class NewsCellRowModel: CellRowModel {
    override func cellReUseID() -> String {
        return "NewsCell"
    }
    
    var name: String?
    
    var date: String?
    
    var headImageURL: String?
    
    var content: String?
    
    var account: String?
    
    var nameLabelAction: ((String)->())?
    
    init(name: String? = nil, date: String? = nil, headImageURL: String? = nil, content: String? = nil, account: String? = nil , nameLabelAction: ((String)->())? ) {
        self.name = name
        self.date = date
        self.headImageURL = headImageURL
        self.content = content
        self.account = account
        self.nameLabelAction = nameLabelAction
    }
}

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    var rowModel: NewsCellRowModel?
    
    override func awakeFromNib() {
        
        self.selectionStyle = .none
        
        self.nameLabel.isUserInteractionEnabled = true
        self.nameLabel.numberOfLines = 1
        self.nameLabel.textColor = .blue
        let tap = UITapGestureRecognizer(target: self, action: #selector(nameLabelAction))
        tap.numberOfTapsRequired = 1
        self.nameLabel.addGestureRecognizer(tap)
        
        self.dateLabel.numberOfLines = 1
        
        self.headImageView.layer.cornerRadius = 25
        
        self.contentTextView.isScrollEnabled = false
        
        self.contentTextView.isEditable = false
        
    }
    
    @objc func nameLabelAction() {
        self.rowModel?.nameLabelAction?(rowModel?.account ?? "")
    }
    
}

extension NewsCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let rowModel = model as? NewsCellRowModel else { return }
        self.rowModel = rowModel
        self.nameLabel.text = rowModel.name
        self.dateLabel.text = rowModel.date
        self.contentTextView.text = rowModel.content
        
        if let urlText = rowModel.headImageURL {
            self.headImageView.setImageFromURL(urlText: urlText)
        } else {
            self.headImageView.image = UIImage(named: "pho_default_pic_home")
        }
        
    }
    
    
    
    
}
