//
//  Mission.swift
//  Moonshot
//
//  Created by Andres Vazquez on 2020-04-27.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        var name: String
        var role: String
    }
    
    var id: Int
    var crew: [CrewRole]
    var description: String
    var launchDate: Date?
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
