//
//  ContentView.swift
//  HabitTracker
//
//  Created by Andres Vazquez on 2020-05-10.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habitsList = HabitsList()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<5) { item in
                    NavigationLink(destination: ContentView()) {
                        Text("Row \(item)")
                    }
                }
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(trailing: Button(action: {
                
            }) {
                Image(systemName: "plus")
            })
            .onAppear {
                self.habitsList.load()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
