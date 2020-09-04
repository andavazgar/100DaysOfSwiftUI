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
    let date = Date()
}

class Prospects: ObservableObject {
    enum SortingOptions {
        case name, creationDate
    }
    
    @Published private(set) var people: [Prospect]
    private static let saveKey = "SavedData"
    
    init() {
        if let data = FileManager.default.loadDocument(named: Self.saveKey) {
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
        
        FileManager.default.saveDocument(named: Self.saveKey, data: encoded, options: [.atomicWrite, .completeFileProtection])
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func sort(by property: SortingOptions) {
        switch property {
        case .name:
            people.sort { $0.name < $1.name }
        case .creationDate:
            people.sort { $0.date < $1.date }
        }
    }
}
