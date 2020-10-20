//
//  AppButton.swift
//  Flashzilla
//
//  Created by Andres Vazquez on 2020-10-31.
//

import SwiftUI

struct AppButton<Label>: View where Label: View {
    let action: () -> Void
    let label: () -> Label
    
    
    var body: some View {
        Button(action: action, label: label)
            .padding()
            .background(Color.black.opacity(0.7))
            .clipShape(Circle())
    }
}

struct AppButton_Previews: PreviewProvider {
    static var previews: some View {
        AppButton(action: {}) {
            Image(systemName: "plus")
        }
    }
}
