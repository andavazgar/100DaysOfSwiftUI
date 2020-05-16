//
//  Task.swift
//  HabitTracker
//
//  Created by Andres Vazquez on 2020-05-11.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

struct Activity: Codable, Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var completionCounter: Int = 0
}
