//
//  NewContactView.swift
//  MeetupContacts
//
//  Created by Andres Vazquez on 2020-08-24.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct NewContactView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var contacts: Contacts
    @State private var image: UIImage?
    @State private var name = ""
    @State private var showingImagePicker = false
    
    var isValidForm: Bool {
        return image != nil && name.isEmpty == false
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    if image != nil {
                        Image(uiImage: image!)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                    } else {
                        Rectangle()
                            .fill(Color.gray.opacity(0.5))
                            .frame(height: 300)
                        
                        Image(systemName: "camera")
                            .font(.largeTitle)
                    }
                }
                .onTapGesture {
                    if self.image == nil {
                        self.showingImagePicker = true
                    }
                }
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: self.$image)
                }
                
                Form {
                    Section(header: Text("Contact Information")) {
                        TextField("Name", text: $name)
                    }
                }
            }
            .navigationBarTitle(Text("New Contact"), displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                self.contacts.addContact(Contact(name: self.name), image: self.image!)
                self.presentationMode.wrappedValue.dismiss()
            }.disabled(!isValidForm)
            )
        }
    }
}

struct NewContactView_Previews: PreviewProvider {
    static var previews: some View {
        NewContactView(contacts: Contacts())
    }
}
