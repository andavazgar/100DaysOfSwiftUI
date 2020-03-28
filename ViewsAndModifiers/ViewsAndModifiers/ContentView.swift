//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Andres Vazquez on 2020-03-27.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("ProminentText")
            Text("(Custom ViewModifier)")
        }
        .prominentText()
    }
}

struct ProminentText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentText() -> some View {
        self.modifier(ProminentText())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
