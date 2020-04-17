//
//  TextfieldWithAccessoryView.swift
//  MultiplicationTables
//
//  Created by Andres Vazquez on 2020-04-13.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct TextfieldWithAccessoryView: UIViewRepresentable {
    var placeholder: String
    var keyboardType: UIKeyboardType
    var position: Position
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> UITextField {
        let textfield = UITextfieldWithAccessoryView()
        textfield.placeholder = placeholder
        textfield.keyboardType = keyboardType
        textfield.font = UIFont.monospacedSystemFont(ofSize: 28, weight: .bold)
        textfield.textAlignment = .center
        textfield.delegate = context.coordinator
        return textfield
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        if position == .current {
            uiView.becomeFirstResponder()
        }
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let char = string.cString(using: String.Encoding.utf8) {
                let characterCode = strcmp(char, "\\b")
                
                // Backspace
                if characterCode == -92 {
                    return true
                } else if string == "\n" && textField.text?.isEmpty == false {
                    NotificationCenter.default.post(name: .submitAnswer, object: textField.text)
                } else if let textLength = textField.text?.count, textLength < 3 {
                    return Int(string) != nil
                }
            }
            
            return false
        }
    }
}


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



struct TextfieldWithAccessoryView_Previews: PreviewProvider {
    static var previews: some View {
        TextfieldWithAccessoryView(placeholder: "?", keyboardType: .numberPad, position: .current)
    }
}
