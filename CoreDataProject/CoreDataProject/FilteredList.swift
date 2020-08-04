//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Andres Vazquez on 2020-08-02.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { element in
            self.content(element)
        }
    }
    
    init(predicate: Predicate = .equal, filterKey: String?, filterValue: String?, sortDescriptors: [NSSortDescriptor] = [], @ViewBuilder content: @escaping (T) -> Content) {
        if let filterKey = filterKey, let filterValue = filterValue {
            fetchRequest = FetchRequest(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue))
        } else {
            fetchRequest = FetchRequest(entity: T.entity(), sortDescriptors: [])
        }
        
        self.content = content
    }
}

enum Predicate: String {
    case equal = "=="
    case notEqual = "!="
    case lessThan = "<"
    case moreThan = ">"
    case lessThanOrEqual = "<="
    case moreThanOrEqual = ">="
    case beginsWith = "BEGINSWITH"
    case beginsWithIgnoringCase = "BEGINSWITH[c]"
    case contains = "CONTAINS"
    case containsIgnoringCase = "CONTAINS[c]"
}
