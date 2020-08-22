//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Andres Vazquez on 2020-05-23.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var orderRef = OrderRef()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $orderRef.order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $orderRef.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(orderRef.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $orderRef.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if orderRef.order.specialRequestEnabled {
                        Toggle(isOn: $orderRef.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $orderRef.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(orderRef: orderRef)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
