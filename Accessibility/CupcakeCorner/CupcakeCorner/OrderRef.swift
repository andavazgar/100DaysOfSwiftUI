//
//  OrderRef.swift
//  CupcakeCorner
//
//  Created by Andres Vazquez on 2020-07-28.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import Foundation

class OrderRef: ObservableObject {
    @Published var order = Order()
}
