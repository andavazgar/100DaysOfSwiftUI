//
//  Movie+CoreDataClass.swift
//  CoreDataProject
//
//  Created by Andres Vazquez on 2020-08-03.
//  Copyright © 2020 Andavazgar. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
    var titleValue: String {
        self.title ?? "Unknown title"
    }
    
    var directorValue: String {
        self.director ?? "Unknown director"
    }
}
