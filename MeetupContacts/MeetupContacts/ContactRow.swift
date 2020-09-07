//
//  ContactRow.swift
//  MeetupContacts
//
//  Created by Andres Vazquez on 2020-08-24.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContactRow: View {
    let contact: Contact
    
    var body: some View {
        NavigationLink(destination:
            DetailsView(contact: contact)
        ) {
            if contact.getImage() != nil {
                Image(uiImage: contact.getImage()!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
            Text(contact.name)
        }
    }
}

struct ContactRow_Previews: PreviewProvider {
    static var previews: some View {
        ContactRow(contact: Contact(name: "John Smith"))
    }
}
