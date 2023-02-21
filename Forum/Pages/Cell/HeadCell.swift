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
    
    init(headImageURLText: String? = nil) {
        self.headImageURLText = headImageURLText
    }
    
}

class HeadCell: UITableViewCell {
    
    @IBOutlet weak var headImageView: UIImageView!
    
    override func awakeFromNib() {
        self.selectionStyle = .none
        self.headImageView.layer.cornerRadius = 25
    }
    
}

extension HeadCell: BaseCellView {
    func setupCellView(model: BaseCellModel) {
        guard let rowModel = model as? HeadCellRowModel else { return }
        
        if let urlText = rowModel.headImageURLText {
            self.headImageView.setImageFromURL(urlText: urlText)
        } else {
            self.headImageView.image = UIImage(named: "pho_default_pic_home")
        }
    }
}
