//
//  NewContactView.swift
//  MeetupContacts
//
//  Created by Andres Vazquez on 2020-08-24.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import CoreLocation
import SwiftUI

struct NewContactView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var contacts: Contacts
    @State private var image: UIImage?
    @State private var name = ""
    @State private var showingImagePicker = false
    @State private var selection = 0
    @State private var location: CLLocationCoordinate2D?
    let locationFetcher = LocationFetcher()
    
    var isValidForm: Bool {
        return image != nil && name.isEmpty == false
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $selection) {
                    Text("Image").tag(0)
                    Text("Location").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                if selection == 0 {
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
                }
                
                if selection == 1 {
                    MapView(location: $location)
                        .frame(height: 300)
                        .onAppear {
                            if let location = self.locationFetcher.lastKnownLocation {
                                self.location = location
                            }
                        }
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
            .onAppear {
                self.locationFetcher.start()
            }
        }
    }
}

struct NewContactView_Previews: PreviewProvider {
    static var previews: some View {
        NewContactView(contacts: Contacts())
    }
}
