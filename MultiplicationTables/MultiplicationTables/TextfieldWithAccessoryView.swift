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
        let textfield = UITextfieldWithAccessoryView()
        textfield.keyboardType = keyboardType
        textfield.font = UIFont.monospacedSystemFont(ofSize: 28, weight: .bold)
        textfield.textAlignment = .center
        return textfield
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }
}


class UITextfieldWithAccessoryView: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        let doneButton = UIBarButtonItem(title: "Submit", style: .done, target: self, action: #selector(sendAnswer))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [flexSpace, doneButton]
        
        self.inputAccessoryView = toolBar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func sendAnswer() {
        NotificationCenter.default.post(name: .submitAnswer, object: nil)
    }
}

extension Notification.Name {
    static let submitAnswer = Notification.Name("submitAnswer")
}



struct TextfieldWithAccessoryView_Previews: PreviewProvider {
    @State private static var testy = ""
    
    static var previews: some View {
        TextfieldWithAccessoryView(text: $testy, keyboardType: .numberPad)
    }
}
