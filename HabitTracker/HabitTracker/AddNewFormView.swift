//
//  AddNewFormView.swift
//  HabitTracker
//
//  Created by Andres Vazquez on 2020-05-12.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct AddNewFormView: View {
    @State private var title = ""
    @State private var description = ""
    
    var body: some View {
        Form {
            TextField("New Activity", text: $title)
            TextField("Description", text: $description)
                .frame(height: 70)
        }
        .navigationBarTitle("Add new activity")
    }
}

struct AddNewFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddNewFormView()
        }
    }
}
