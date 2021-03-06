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
                    NavigationLink(destination: FormView(habitsList: self.habitsList, activity: activity)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(activity.title)
                                    .font(.headline)
                                
                                Text(activity.description)
                                    .font(.callout)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            Text("×\(activity.completionCount)")
                                .padding(.trailing, 5)
                        }
                    }
                }
                .onDelete(perform: habitsList.remove)
            }
            .navigationBarTitle("Habit Tracker")
            .navigationBarItems(trailing: Button(action: {
                self.showAddNewFormView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showAddNewFormView) {
                NavigationView {
                    FormView(habitsList: self.habitsList)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
