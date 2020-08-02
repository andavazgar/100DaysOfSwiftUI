//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Andres Vazquez on 2020-07-31.
//  Copyright © 2020 Andavazgar. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
    
    public var titleValue: String {
        return title ?? "Unknown title"
    }
    
    public var directorValue: String {
        return director ?? "Unknown director"
    }
}
