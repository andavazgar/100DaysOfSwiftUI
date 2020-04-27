//
//  ContentView.swift
//  Moonshot
//
//  Created by Andres Vazquez on 2020-04-26.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                GeometryReader { geo in
                    Image("hws")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width)
                }
    
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(0..<100) {
                            Text("Item \($0)")
                                .font(.title)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                NavigationLink(destination: Text("Details View")) {
                    Text("Hello World")
                }
                .padding(.vertical, 25)
                
                Button("Decode JSON") {
                    let input = """
                    {
                        "name": "Taylor Swift",
                        "address": {
                            "street": "555, Taylor Swift Avenue",
                            "city": "Nashville"
                        }
                    }
                    """
                    
                    struct User: Codable {
                        var name: String
                        var address: Address
                    }
                    
                    struct Address: Codable {
                        var street: String
                        var city: String
                    }

                    let data = Data(input.utf8)
                    let decoder = JSONDecoder()
                    
                    if let user = try? decoder.decode(User.self, from: data) {
                        print(user.address.street)
                    }
                }
            }
            .navigationBarTitle("SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
