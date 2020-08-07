//
//  Friend+CoreDataClass.swift
//  Friendface
//
//  Created by Andres Vazquez on 2020-08-06.
//  Copyright © 2020 Andavazgar. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Decodable, Identifiable {
    var nameValue: String {
        self.name ?? "Unknown name"
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyContext] as? NSManagedObjectContext else {
            fatalError("Failed to decode Friend")
        }
        
        self.init(context: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}
