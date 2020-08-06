//
//  ContentView.swift
//  Friendface
//
//  Created by Andres Vazquez on 2020-08-05.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        NavigationView {
            List(env.users) { (user: User) in
                NavigationLink(destination: DetailView(user: user)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("[\(user.friends.count)]")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                }
            }
            .navigationBarTitle("Friendface")
            .onAppear {
                self.fetchUsers()
            }
        }
    }
    
    private func fetchUsers() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let decodedUsers = try decoder.decode([User].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.env.users = decodedUsers
                    }
                    return
                } catch {
                    print("Error decoding users:", error)
                }
            }
            
            print("Error fetching users:", error?.localizedDescription ?? "")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
