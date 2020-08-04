//
//  Country+CoreDataClass.swift
//  CoreDataProject
//
//  Created by Andres Vazquez on 2020-08-03.
//  Copyright © 2020 Andavazgar. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Country)
public class Country: NSManagedObject {
    var shortNameValue: String {
        self.shortName ?? "Unknown country"
    }
    
    var fullNameValue: String {
        self.fullName ?? "Unknown country"
    }
    
    var candyArray: [Candy] {
        let candies = self.candy as? Set<Candy> ?? []
        return candies.sorted { $0.nameValue < $1.nameValue }
    }
}
