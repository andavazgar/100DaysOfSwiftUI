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
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(placeholder: placeholder)
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = font
        textView.text = placeholder
        textView.textColor = .lightGray
        textView.delegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var placeholder: String
        
        init(placeholder: String) {
            self.placeholder = placeholder
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let currentText:String = textView.text
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

            if updatedText.isEmpty {
                textView.text = placeholder
                textView.textColor = UIColor.lightGray
                
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            } else if textView.textColor == UIColor.lightGray && !text.isEmpty {
                textView.textColor = .black
                textView.text = text
            } else {
                return true
            }
            
            return false
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
