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
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = TextViewWithPlaceholder()
        textView.setup(placeholder: placeholder)
        textView.font = font
        textView.delegate = context.coordinator
        
        context.coordinator.textView = textView
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var textView: TextViewWithPlaceholder!
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            let currentText:String = textView.text
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)

            if updatedText.isEmpty {
                self.textView.showPlaceholder()
            } else {
                self.textView.hidePlaceholder()
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
