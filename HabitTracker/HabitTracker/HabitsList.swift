//
//  Activities.swift
//  HabitTracker
//
//  Created by Andres Vazquez on 2020-05-11.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

class HabitsList: ObservableObject, Codable {
    @Published var activities = [Activity]()
    
    init() {
        load()
    }
    
    func add(newActivity activity: Activity) {
        self.activities.append(activity)
        save()
    }
    
    func edit(activity: Activity) {
        if let indexToReplace = activities.firstIndex(where: { $0.id == activity.id }) {
            activities[indexToReplace] = activity
            save()
        }
    }
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: "HabitsList") else { return }
        
        let decoder = JSONDecoder()
        if let list = try? decoder.decode(HabitsList.self, from: data) {
            activities = list.activities
        }
    }
    
    func save() {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(self) {
            UserDefaults.standard.set(data, forKey: "HabitsList")
        }
        
    }
    
    // MARK: - Needed for Codable
    enum CodingKeys: CodingKey {
        case activities
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        activities = try container.decode([Activity].self, forKey: .activities)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(activities, forKey: .activities)
    }
}

struct HabitsList_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
