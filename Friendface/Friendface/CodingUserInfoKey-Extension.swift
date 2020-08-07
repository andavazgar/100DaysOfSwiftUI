//
//  CodingUserInfoKey-Extension.swift
//  Friendface
//
//  Created by Andres Vazquez on 2020-08-06.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
