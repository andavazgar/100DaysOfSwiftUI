//
//  Ship+CoreDataClass.swift
//  CoreDataProject
//
//  Created by Andres Vazquez on 2020-08-03.
//  Copyright © 2020 Andavazgar. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Ship)
public class Ship: NSManagedObject {
    var nameValue: String {
        self.name ?? "Unknown ship"
    }
    
    var universeValue: String {
        self.universe ?? "Unknown universe"
    }
}
