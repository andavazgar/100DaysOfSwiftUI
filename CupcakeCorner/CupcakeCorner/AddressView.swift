//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Andres Vazquez on 2020-05-29.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orderRef: OrderRef
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $orderRef.order.name)
                TextField("Street Address", text: $orderRef.order.streetAddress)
                TextField("City", text: $orderRef.order.city)
                TextField("Zip", text: $orderRef.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(orderRef: orderRef)) {
                    Text("Check out")
                }
            }
            .disabled(orderRef.order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(orderRef: OrderRef())
        }
    }
}
