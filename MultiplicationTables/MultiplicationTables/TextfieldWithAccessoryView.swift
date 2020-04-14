//
//  TextfieldWithAccessoryView.swift
//  MultiplicationTables
//
//  Created by Andres Vazquez on 2020-04-13.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct TextfieldWithAccessoryView: UIViewRepresentable {
    @Binding var text: String
    var keyboardType: UIKeyboardType
    
    func makeUIView(context: Context) -> UITextField {
        let textfield = UITextField()
        textfield.keyboardType = keyboardType
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: textfield.frame.size.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(textfield.doneButtonTapped(button:)))
        toolBar.items = [doneButton]
        toolBar.setItems([doneButton], animated: true)
        
        textfield.inputAccessoryView = toolBar
        return textfield
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}

extension  UITextField{
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
       self.resignFirstResponder()
    }

}
