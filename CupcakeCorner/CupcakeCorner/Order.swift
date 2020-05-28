//
//  Order.swift
//  CupcakeCorner
//
//  Created by Andres Vazquez on 2020-05-26.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false
    @Published var extraFrosting = false
    @Published var addSprinkles = false
}
