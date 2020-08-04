//
//  Candy+CoreDataClass.swift
//  CoreDataProject
//
//  Created by Andres Vazquez on 2020-08-03.
//  Copyright © 2020 Andavazgar. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Candy)
public class Candy: NSManagedObject {
    var nameValue: String {
        self.name ?? "Unknown candy"
    }
}
