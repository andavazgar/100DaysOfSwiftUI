//
//  UITextfieldWithAccessoryView.swift
//  MultiplicationTables
//
//  Created by Andres Vazquez on 2020-04-17.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import UIKit

class UITextfieldWithAccessoryView: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)

        let toolBar = UIToolbar()
        let dismissKeyboardBtn = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .plain, target: self, action: #selector(dismissKeyboard))
        dismissKeyboardBtn.tintColor = .darkGray

        let submitBtn = UIBarButtonItem(title: "Submit", style: .done, target: self, action: #selector(sendAnswer))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [dismissKeyboardBtn, flexSpace, submitBtn]
        toolBar.sizeToFit()

        self.inputAccessoryView = toolBar
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func dismissKeyboard() {
        self.resignFirstResponder()
    }

    @objc private func sendAnswer() {
        if self.text?.isEmpty == false {
            NotificationCenter.default.post(name: .submitAnswer, object: self.text)
        }
    }
}

extension Notification.Name {
    static let submitAnswer = Notification.Name("submitAnswer")
}
