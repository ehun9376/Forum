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
    
    var moreButtonAcction: (()->())?
    
    var isOpen: Bool = false
    
    init(name: String? = nil, date: String? = nil, headImageURL: String? = nil, content: String? = nil, account: String? = nil , nameLabelAction: ((String)->())?, moreButtonAcction: (()->())? ) {
        self.name = name
        self.date = date
        self.headImageURL = headImageURL
        self.content = content
        self.account = account
        self.nameLabelAction = nameLabelAction
        self.moreButtonAcction = moreButtonAcction
    }
}

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var insideView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    var rowModel: NewsCellRowModel?
    
    override func awakeFromNib() {
        
        self.selectionStyle = .none
        
        self.contentView.backgroundColor = .lightGray
        
        self.insideView.backgroundColor = .white
        self.insideView.layer.borderWidth = 0.5
        self.insideView.layer.borderColor = UIColor.lightGray.cgColor
        self.insideView.layer.cornerRadius = 5
        self.insideView.clipsToBounds = true
        
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
        self.contentTextView.font = .systemFont(ofSize: 16)
        
        self.moreButton.addTarget(self, action: #selector(moreButtonAction(_:)), for: .touchUpInside)
        
    }
    
    @objc func moreButtonAction(_ sender:UIButton) {
        self.rowModel?.isOpen.toggle()
        

        
        self.textViewHeight.constant = self.rowModel?.isOpen ?? true ? (self.rowModel?.content ?? "").heightForLabel(width: self.contentTextView.frame.width, font: .systemFont(ofSize: 16)) : 100//self.rowModel?.isOpen ?? true ? CGFloat(self.contentTextView.contentOfLines()) * UIFont.systemFont(ofSize: 16).lineHeight : 100
        
        sender.setTitle(self.rowModel?.isOpen ?? true ? "查看更少" : "查看更多", for: .normal)
        self.rowModel?.moreButtonAcction?()
        
    }
    
    @objc func nameLabelAction() {
        self.rowModel?.nameLabelAction?(rowModel?.account ?? "")
    }
}

extension NewsCell: CellBinding {

    func setupCellView(model: CellModelBase) {
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
        
        
        self.textViewHeight.constant = 100

        
        self.moreButton.setTitle(rowModel.isOpen ? "查看更少" : "查看更多", for: .normal)
        self.moreButton.isHidden = (self.rowModel?.content ?? "").heightForLabel(width: self.contentTextView.frame.width, font: .systemFont(ofSize: 16)) <= 100
    }
    
    
    
    
}
