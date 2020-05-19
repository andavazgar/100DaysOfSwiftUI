//
//  FormView.swift
//  HabitTracker
//
//  Created by Andres Vazquez on 2020-05-12.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct FormView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var description = ""
    var habitsList: HabitsList
    var activity: Activity?
    var editedActivity: Activity {
        var editedActivity = activity
        editedActivity?.title = title
        editedActivity?.description = description
        return editedActivity!
    }
    
    var body: some View {
        Form {
            TextField("New Activity", text: $title)
            TextView(text: $description, placeholder: "Description")
                .frame(height: 70)
                .font(.headline)
            Section {
                if activity != nil {
                    Button("Save changes") {
                        self.habitsList.edit(activity: self.editedActivity)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    Button("Add") {
                        self.habitsList.add(newActivity: Activity(title: self.title, description: self.description))
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .navigationBarTitle("Add new activity")
        .onAppear() {
            if let activity = self.activity {
                self.title = activity.title
                self.description = activity.description
            }
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(habitsList: HabitsList())
    }
}
