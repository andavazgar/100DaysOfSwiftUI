//
//  AddNewFormView.swift
//  HabitTracker
//
//  Created by Andres Vazquez on 2020-05-12.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct AddNewFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var description = ""
    var habitsList: HabitsList
    
    var body: some View {
        NavigationView {
            Form {
                TextField("New Activity", text: $title)
                TextView(text: $description, placeholder: "Description")
                    .frame(height: 70)
                    .font(.headline)
                Section {
                    Button("Add") {
                        self.habitsList.add(newActivity: Activity(title: self.title, description: self.description))
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationBarTitle("Add new activity")
        }
    }
}

struct AddNewFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewFormView(habitsList: HabitsList())
    }
}
