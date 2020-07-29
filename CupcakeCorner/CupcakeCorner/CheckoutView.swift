//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Andres Vazquez on 2020-07-28.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct AlertObj {
    var title = ""
    var message = ""
}

struct CheckoutView: View {
    @ObservedObject var orderRef: OrderRef
    @State private var alertObj = AlertObj()
    @State private var showingAlert = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.orderRef.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(self.alertObj.title), message: Text(self.alertObj.message), dismissButton: .default(Text("OK")))
        }
    }
    
    private func placeOrder() {
        guard let encodedOrder = try? JSONEncoder().encode(orderRef.order) else {
            print("Failed to encode the order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encodedOrder
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                self.alertObj.title = "Error"
                self.alertObj.message = "\(error?.localizedDescription ?? "No data received from the server. Check your internet connection.")"
                self.showingAlert = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.alertObj.title = "Thank you!"
                self.alertObj.message = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingAlert = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(orderRef: OrderRef())
        }
    }
}
