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
    @State private var showAddNewFormView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habitsList.activities) { activity in
                    NavigationLink(destination: ContentView()) {
                        VStack {
                            Text(activity.title)
                            Text(activity.description)
                        }
                    }
                }
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(trailing: Button(action: {
                self.showAddNewFormView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showAddNewFormView) {
                AddNewFormView(habitsList: self.habitsList)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
