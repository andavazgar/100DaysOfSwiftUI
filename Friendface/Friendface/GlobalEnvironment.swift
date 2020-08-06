//
//  GlobalEnvironment.swift
//  Friendface
//
//  Created by Andres Vazquez on 2020-08-05.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

class GlobalEnvironment: ObservableObject {
    @Published var users = [User]()
}
