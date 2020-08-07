//
//  ContentView.swift
//  Friendface
//
//  Created by Andres Vazquez on 2020-08-05.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: User.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \User.name, ascending: true)
    ]) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List(users) { (user: User) in
                NavigationLink(destination: DetailView(user: user)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(user.nameValue)
                                .font(.headline)
                            
                            Text(user.emailValue)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Text("[\(user.friendsValue.count)]")
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
        if users.isEmpty {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = context
            
            decoder.decode([User].self, fromURL: "https://www.hackingwithswift.com/samples/friendface.json") { result in
                switch result {
                case .success(_):
                    if self.context.hasChanges {
                        do {
                            try self.context.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
