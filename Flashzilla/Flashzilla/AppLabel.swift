//
//  AppLabel.swift
//  Flashzilla
//
//  Created by Andres Vazquez on 2020-11-24.
//

import SwiftUI

struct AppLabel: View {
    let content: String
    let color: Color
    
    init<S>(_ content: S, color: Color = .white) where S : StringProtocol {
        self.content = String(content)
        self.color = color
    }
    
    var body: some View {
        Text(content)
            .foregroundColor(color)
            .padding(.vertical, 5)
            .padding(.horizontal, 15)
            .background(
                Capsule()
                    .fill(Color.black)
                    .opacity(0.7))
    }
}

struct AppLabel_Previews: PreviewProvider {
    static var previews: some View {
        AppLabel("Test")
    }
}
