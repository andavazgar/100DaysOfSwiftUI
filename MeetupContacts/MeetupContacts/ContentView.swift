//
//  ContentView.swift
//  MeetupContacts
//
//  Created by Andres Vazquez on 2020-08-24.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var contacts = Contacts()
    @State private var showingNewContactSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contacts.list.sorted()) { contact in
                    ContactRow(contact: contact)
                }
            }
            .navigationBarTitle("Meetup Contacts")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showingNewContactSheet = true
            }) {
                Image(systemName: "plus")
            })
            .onAppear {
                self.contacts.loadContacts()
            }
            .sheet(isPresented: $showingNewContactSheet) {
                NewContactView(contacts: self.contacts)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
