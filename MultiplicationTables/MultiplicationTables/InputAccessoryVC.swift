//
//  InputAccessoryVC.swift
//  MultiplicationTables
//
//  Created by Andres Vazquez on 2020-04-13.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let submitAnswer = Notification.Name("submitAnswer")
}

class TextfieldWithAccessoryVC: UIViewController {
    let textfield = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar(frame: .zero)
        let doneButton = UIBarButtonItem(title: "Submit", style: .done, target: self, action: #selector(sendAnswer))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.items = [flexSpace, doneButton]
        
        textfield.inputAccessoryView = toolBar
    }
    
    @objc private func sendAnswer() {
        NotificationCenter.default.post(name: .submitAnswer, object: nil)
    }
}
