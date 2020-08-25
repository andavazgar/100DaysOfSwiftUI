//
//  Contact.swift
//  MeetupContacts
//
//  Created by Andres Vazquez on 2020-08-24.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

struct Contact: Identifiable, Codable, Comparable {
    var id = UUID()
    var name: String
    
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name < rhs.name
    }
}
