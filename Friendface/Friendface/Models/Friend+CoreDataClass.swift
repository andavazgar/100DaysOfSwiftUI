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
public class Friend: NSManagedObject, Decodable {
    var nameValue: String {
        self.name ?? "Unknown name"
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Friend", in: managedObjectContext) else {
            fatalError("Failed to decode Friend")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}
