//
//  Contact.swift
//  MeetupContacts
//
//  Created by Andres Vazquez on 2020-08-24.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct Contact: Identifiable, Codable, Comparable {
    let id = UUID()
    var name: String
    var location: Coordinate?
    
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        lhs.name < rhs.name
    }
    
    func getImage() -> UIImage? {
        if let imageData = FileManager.default.getDocument(self.id.uuidString) {
            return UIImage(data: imageData)
        } else {
            fatalError("Could not load image")
        }
    }
}

struct Coordinate: Codable, Comparable {
    var latitude: Double
    var longitude: Double
    
    static func < (lhs: Coordinate, rhs: Coordinate) -> Bool {
        lhs.latitude < rhs.latitude
    }
}
