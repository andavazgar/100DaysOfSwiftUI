//
//  TextViewWithPlaceholder.swift
//  HabitTracker
//
//  Created by Andres Vazquez on 2020-05-15.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import UIKit

class TextViewWithPlaceholder: UITextView {
    private var placeholderLabel: UILabel!
    
    func setup(placeholder: String) {
        self.contentInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        placeholderLabel = UILabel()
        placeholderLabel.textColor = UIColor.lightGray.withAlphaComponent(0.75)
        placeholderLabel.text = placeholder
        
        self.addSubview(placeholderLabel)
        
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 9)
        ])
    }
    
    func hidePlaceholder() {
        placeholderLabel.isHidden = true
    }
    
    func showPlaceholder() {
        placeholderLabel.isHidden = false
    }
}
