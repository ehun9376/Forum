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
    
    
    var nameLabelAction: (()->())?
    
    var heightChangeAction: (()->())?
    
    var isOpen: Bool = false
    
    init(name: String? = nil, date: String? = nil, headImageURL: String? = nil, content: String? = nil, nameLabelAction: (()->())?, heightChangeAction: (()->())? ) {
        self.name = name
        self.date = date
        self.headImageURL = headImageURL
        self.content = content
        self.nameLabelAction = nameLabelAction
        self.heightChangeAction = heightChangeAction
    }
}

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var insideView: UIView!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    var rowModel: NewsCellRowModel?
    
    var normalSize: CGFloat = 100
    
    var isOpen: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.2) {
                self.moreButton.isHidden = self.isOpen
                self.textViewHeight.constant = self.isOpen ? self.contentTextView.contentOfHeight() : self.normalSize
                self.rowModel?.heightChangeAction?()
            }
        }
    }
    
    override func awakeFromNib() {
        
        self.selectionStyle = .none
        
        self.contentView.backgroundColor = .lightGray
        
        self.insideView.backgroundColor = .white
        self.insideView.layer.borderWidth = 0.5
        self.insideView.layer.borderColor = UIColor.lightGray.cgColor
        self.insideView.layer.cornerRadius = 5
        self.insideView.clipsToBounds = true
        
        self.dateLabel.numberOfLines = 1
                
        self.contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentTextView.layer.borderWidth = 0.5
        self.contentTextView.layer.cornerRadius = 5
        self.contentTextView.isScrollEnabled = false
        self.contentTextView.isEditable = false
        self.contentTextView.font = .systemFont(ofSize: 16)
        
        let textViewTap = UITapGestureRecognizer(target: self, action: #selector(contentTextViewTapAction(_:)))
        textViewTap.numberOfTapsRequired = 1
        self.contentTextView.addGestureRecognizer(textViewTap)
        
        self.moreButton.addTarget(self, action: #selector(moreButtonAction(_:)), for: .touchUpInside)
        
    }
    
    @objc func contentTextViewTapAction(_ sender: UITextView) {
        if self.isOpen {
            self.isOpen.toggle()
        }
    }
    
    @objc func moreButtonAction(_ sender:UIButton) {
        self.isOpen.toggle()
    }
    
    @objc func nameLabelAction() {
        self.rowModel?.nameLabelAction?()
    }
}

extension NewsCell: CellBinding {

    func setupCellView(model: CellModelBase) {
        guard let rowModel = model as? NewsCellRowModel else { return }
        self.rowModel = rowModel
        self.dateLabel.text = rowModel.date
        self.contentTextView.text = rowModel.content
                
        self.textViewHeight.constant = normalSize
        
        self.moreButton.setTitle(rowModel.isOpen ? "查看更少" : "查看更多", for: .normal)
        self.moreButton.isHidden = self.contentTextView.contentOfHeight() <= normalSize
    }
    
    
    
    
}
