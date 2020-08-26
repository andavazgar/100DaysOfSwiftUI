//
//  Contacts.swift
//  MeetupContacts
//
//  Created by Andres Vazquez on 2020-08-24.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

class Contacts: ObservableObject {
    private let filename = "contacts"
    @Published private(set) var list: [Contact]
    
    init(_ contacts: [Contact] = []) {
        self.list = contacts
    }
    
    func addContact(_ contact: Contact, image: UIImage) {
        if let imageData = image.jpegData(compressionQuality: 0.8) {
            FileManager.default.saveDocument(contact.id.uuidString, with: imageData, options: [.atomicWrite, .completeFileProtection])
        }
        
        list.append(contact)
        saveContacts()
    }
    
    func deleteContacts(at indexes: IndexSet) {
        for index in indexes {
            list.remove(at: index)
        }
        saveContacts()
    }
    
    func loadContacts() {
        guard let data = FileManager.default.getDocument(filename) else { return }
        
        do {
            list = try JSONDecoder().decode([Contact].self, from: data)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func saveContacts() {
        guard let data = try? JSONEncoder().encode(list) else { return }
        
        FileManager.default.saveDocument(filename, with: data, options: [.atomicWrite, .completeFileProtection])
    }
}
