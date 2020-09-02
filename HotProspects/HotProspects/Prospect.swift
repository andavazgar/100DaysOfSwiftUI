//
//  Prospect.swift
//  HotProspects
//
//  Created by Andres Vazquez on 2020-09-01.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var email = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    private static let saveKey = "SavedData"
    
    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
        
        self.people = []
    }
    
    func add(_ person: Prospect) {
        self.people.append(person)
        save()
    }
    
    private func save() {
        guard let encoded = try? JSONEncoder().encode(people) else { return }
        
        UserDefaults.standard.set(encoded, forKey: Self.saveKey)
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
