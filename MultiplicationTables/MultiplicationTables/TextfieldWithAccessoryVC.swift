//
//  TextfieldWithAccessoryVC.swift
//  MultiplicationTables
//
//  Created by Andres Vazquez on 2020-04-15.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI
//
//struct TextfieldWithAccessoryView: UIViewControllerRepresentable {
//    @Binding var text: String
//    var keyboardType: UIKeyboardType
//    
//    func makeUIViewController(context: Context) -> UITextfieldWithAccessoryView {
//        let textfieldVC = UITextfieldWithAccessoryView()
//        textfieldVC.textfield.keyboardType = keyboardType
//        textfieldVC.textfield.font = UIFont.monospacedSystemFont(ofSize: 28, weight: .bold)
//        textfieldVC.textfield.textAlignment = .center
//        
//        return textfieldVC
//    }
//    
//    func updateUIViewController(_ uiViewController: UITextfieldWithAccessoryView, context: Context) {
//        uiViewController.textfield.text = text
//    }
//}
//
//
//class UITextfieldWithAccessoryView: UIViewController {
//    
//    var textfield = UITextField()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let toolBar = UIToolbar()
//        let dismissKeyboardBtn = UIBarButtonItem(image: UIImage(systemName: "keyboard.chevron.compact.down"), style: .plain, target: self, action: #selector(dismissKeyboard))
//        dismissKeyboardBtn.tintColor = .darkGray
//        
//        let submitBtn = UIBarButtonItem(title: "Submit", style: .done, target: self, action: #selector(sendAnswer))
//        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        toolBar.items = [dismissKeyboardBtn, flexSpace, submitBtn]
//        toolBar.sizeToFit()
//        
//        textfield.inputAccessoryView = toolBar
//    }
//    
//    @objc private func dismissKeyboard() {
//        self.resignFirstResponder()
//    }
//    
//    @objc private func sendAnswer() {
//        if textfield.text?.isEmpty == false {
//            print("sending...")
//            NotificationCenter.default.post(name: .submitAnswer, object: nil)
//        }
//    }
//}
//
//extension Notification.Name {
//    static let submitAnswer = Notification.Name("submitAnswer")
//}
//
//
//
//struct TextfieldWithAccessoryView_Previews: PreviewProvider {
//    @State private static var testy = ""
//    
//    static var previews: some View {
//        TextfieldWithAccessoryView(text: $testy, keyboardType: .numberPad)
//    }
//}
