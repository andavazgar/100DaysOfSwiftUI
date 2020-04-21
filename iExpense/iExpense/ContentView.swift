//
//  ContentView.swift
//  iExpense
//
//  Created by Andres Vazquez on 2020-04-20.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName: String
    @Published var lastName: String
    
    init() {
        firstName = "Bilbo"
        lastName = "Baggins"
    }
}

struct ContentView: View {
    @ObservedObject var user = User()
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    @State private var isShowingSheet = false
    @State private var taps = UserDefaults.standard.integer(forKey: "Taps")
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Name: \(user.firstName) \(user.lastName)")
                
                TextField("First Name", text: $user.firstName)
                TextField("Last Name", text: $user.lastName)
                
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button("Add number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
                
                Button("Show sheet") {
                    self.isShowingSheet.toggle()
                }
                .padding(.vertical, 40)
                
                Button("Remember taps: \(taps)") {
                    self.taps += 1
                    UserDefaults.standard.set(self.taps, forKey: "Taps")
                }
            }
            .navigationBarItems(leading: EditButton())
            .sheet(isPresented: $isShowingSheet) {
                SecondView()
            }
        }
    }
    
    private func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.blue
                .edgesIgnoringSafeArea(.all)
            
            Button("Dismiss sheet") {
                self.presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
