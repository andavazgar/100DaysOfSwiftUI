//
//  ContentView.swift
//  WeSplit
//
//  Created by Andres Vazquez on 2020-03-23.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Hello, World!")
                    Text("Hello, World!")
                    Text("Hello, World!")
                }
                
                Section {
                    Text("Hello, World!")
                    Text("Hello, World!")
                    Text("Hello, World!")
                }
                
                NavigationLink("Go to next screen", destination: ContentViewWithState())
            }
            .navigationBarTitle("SwiftUI")
        }
    }
}

struct ContentViewWithState: View {
    @State private var tapCount = 0
    let students = ["Harry", "Herminone", "Ron"]
    @State private var selectedStudent = 0
    
    var body: some View {
        VStack {
            Button("Tap Count: \(tapCount)") {
                self.tapCount += 1
            }
            Picker("Select your student", selection: $selectedStudent) {
                ForEach(0 ..< students.count) {
                    Text(self.students[$0])
                }
            }
            Text("You chose: \(students[selectedStudent])")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDisplayName("ContentView")
            ContentViewWithState()
            .previewDisplayName("ContentViewWithState")
        }
    }
}
