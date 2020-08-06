//
//  Friend.swift
//  Friendface
//
//  Created by Andres Vazquez on 2020-08-05.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}
