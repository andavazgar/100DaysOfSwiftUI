//
//  DetailsView.swift
//  MeetupContacts
//
//  Created by Andres Vazquez on 2020-09-11.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import MapKit
import SwiftUI

struct DetailsView: View {
    @State private var selection = 0
    
    let contact: Contact
    
    var body: some View {
        VStack {
            if contact.location != nil {
                Picker("", selection: $selection) {
                    Text("Image").tag(0)
                    Text("Location").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            if selection == 0 {
                Image(uiImage: contact.getImage()!)
                    .resizable()
                    .scaledToFill()
                
            } else if selection == 1 {
                MapView(location: .constant(CLLocationCoordinate2D(latitude: contact.location!.latitude, longitude: contact.location!.longitude)))
            }
        }
        .navigationBarTitle(Text(contact.name), displayMode: .inline)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(contact: Contact(name: "Amy"))
    }
}
