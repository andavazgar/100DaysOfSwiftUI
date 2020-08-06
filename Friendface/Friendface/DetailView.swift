//
//  DetailView.swift
//  Friendface
//
//  Created by Andres Vazquez on 2020-08-05.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var env: GlobalEnvironment
    var user: User
    
    var body: some View {
        Form {
            Section {
                UserDetailRowView(label: "Name:", value: user.name)
                UserDetailRowView(label: "Age:", value: "\(user.age)")
                UserDetailRowView(label: "Company:", value: user.company)
                UserDetailRowView(label: "Email:", value: user.email)
                UserDetailRowView(label: "Address:", value: user.address)
            }
            
            Section(header: Text("About").font(.headline)) {
                NavigationLink(destination: VStack {
                    Text(user.about)
                        .padding()
                    Spacer()
                        .navigationBarTitle("About", displayMode: .inline)
                }) {
                    Text(user.about)
                        .lineLimit(5)
                }
            }
            
            Section(header: Text("Friends").font(.headline)) {
                ForEach(user.friends) { friend in
                    NavigationLink(destination: DetailView(user: self.findUser(withId: friend.id))) {
                        Text(friend.name)
                    }
                }
            }
        }
        .navigationBarTitle(Text("User Details"), displayMode: .inline)
    }
    
    private func findUser(withId id: UUID) -> User {
        return env.users.first { $0.id == id }!
    }
}

struct UserDetailRowView: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.headline)
            Spacer()
            Text(value)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static let user = User(id: UUID(), isActive: true, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about: "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.\r\n", registered: Date(), tags: [
        "cillum",
        "consequat",
        "deserunt",
        "nostrud",
        "eiusmod",
        "minim",
        "tempor"
        ], friends: [
        Friend(id: UUID(), name: "Hawkins Patel"),
        Friend(id: UUID(), name: "Jewel Sexton")
    ])
    
    static var previews: some View {
        NavigationView {
            DetailView(user: user)
        }
    }
}
