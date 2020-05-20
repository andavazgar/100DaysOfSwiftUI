//
//  TextView.swift
//  HabitTracker
//
//  Created by Andres Vazquez on 2020-05-13.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String = ""
    var font: UIFont = UIFont.preferredFont(forTextStyle: .body)
    @State private var textView = TextViewWithPlaceholder()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UITextView {
        textView.setup(placeholder: placeholder)
        textView.font = font
        textView.delegate = context.coordinator
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if textView.text.isEmpty {
            self.textView.showPlaceholder()
        } else {
            self.textView.hidePlaceholder()
        }
        uiView.text = text
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(parent: TextView) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            if textView.text.isEmpty {
                self.parent.textView.showPlaceholder()
            } else {
                self.parent.textView.hidePlaceholder()
            }
            parent.text = textView.text
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(text: .constant("Hello"))
            .previewLayout(.sizeThatFits)
    }
}
