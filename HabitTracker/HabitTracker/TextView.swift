//
//  TextView.swift
//  HabitTracker
//
//  Created by Andres Vazquez on 2020-05-13.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct TextViewRepresentable: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var font: UIFont
    @State private var placeholderLabel: UILabel?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(placeholder: placeholderLabel)
    }
    
    func makeUIView(context: Context) -> UITextView {
        placeholderLabel = UILabel()
        placeholderLabel!.textColor = .lightGray
        placeholderLabel!.text = placeholder
        
        let textView = UITextView()
        textView.font = font
        textView.delegate = context.coordinator
        
        textView.addSubview(placeholderLabel!)
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var placeholder: UILabel!
        
        init(placeholder: UILabel?) {
            self.placeholder = placeholder
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let currentText:String = textView.text
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

            if updatedText.isEmpty {
                placeholder.isHidden = false
            } else {
                placeholder.isHidden = true
            }
            
            return true
        }
    }
}

struct TextView: View {
    @Binding var text: String
    var placeholder: String = ""
    var font: UIFont = UIFont.preferredFont(forTextStyle: .body)
    
    var body: some View {
        TextViewRepresentable(text: $text, placeholder: placeholder, font: font)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(text: .constant("Hello"))
            .previewLayout(.sizeThatFits)
    }
}
