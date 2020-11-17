//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Andres Vazquez on 2020-10-31.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var retryMistakes: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle("Retry incorrect cards", isOn: $retryMistakes)
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(retryMistakes: .constant(true))
    }
}
