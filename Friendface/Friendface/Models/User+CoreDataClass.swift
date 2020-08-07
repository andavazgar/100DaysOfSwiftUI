//
//  User+CoreDataClass.swift
//  Friendface
//
//  Created by Andres Vazquez on 2020-08-06.
//  Copyright © 2020 Andavazgar. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Decodable, Identifiable {
    var nameValue: String {
        self.name ?? "Unknown name"
    }
    var ageValue: String {
        "\(self.age)"
    }
    var companyValue: String {
        self.company ?? "Unknown company"
    }
    var emailValue: String {
        self.email ?? "Unknown email"
    }
    var addressValue: String {
        self.address ?? "Unknown address"
    }
    var aboutValue: String {
        self.about ?? "Unknown about"
    }
    var tagsValue: [String] {
        self.tags ?? []
    }
    var friendsValue: [Friend] {
        let friendsSet = friends as? Set<Friend> ?? []
        
        return friendsSet.sorted { $0.nameValue < $1.nameValue }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
            fatalError("Failed to decode User")
        }

        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int16.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        about = try container.decode(String.self, forKey: .about)
        registered = try container.decode(Date.self, forKey: .registered)
        tags = try container.decode([String].self, forKey: .tags)
        let tempFriends = try container.decode([Friend].self, forKey: .friends)
        friends = Set(tempFriends) as NSSet
    }
}
