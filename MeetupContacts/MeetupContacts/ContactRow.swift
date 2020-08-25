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
    let image: UIImage!
    
    init(contact: Contact) {
        self.contact = contact
        if let imageData = FileManager.default.getDocument(contact.id.uuidString) {
            image = UIImage(data: imageData)
        } else {
            fatalError("Could not load image")
        }
    }
    
    var body: some View {
        NavigationLink(destination:
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .navigationBarTitle(Text(contact.name), displayMode: .inline)
        ) {
            if image != nil {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
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
