//
//  PlaceHolderTextView.swift
//  Forum
//
//  Created by 陳逸煌 on 2023/2/20.
//

import Foundation
import UIKit

class PlaceHolderTextView: UITextView {
    
    let placeHolderLabel = UILabel()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    convenience init(
        placeHolderText: String
    ) {
        self.init()
        self.setupView(placeHolder: placeHolderText)
    }
    
    func setupView(placeHolder: String) {
        self.delegate = self
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.placeHolderLabel.text = placeHolder
        self.placeHolderLabel.textColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        self.font = .systemFont(ofSize: 16)
        
        self.addSubview(self.placeHolderLabel)
        
        NSLayoutConstraint.activate([
            self.placeHolderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            self.placeHolderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3),
            self.placeHolderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
    }
    
}

extension PlaceHolderTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.placeHolderLabel.isHidden = true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.placeHolderLabel.isHidden = !textView.text.isEmpty
        return true
    }
}
