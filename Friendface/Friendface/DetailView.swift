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
                UserDetailRowView(label: "Age:", value: "\(user.age)")
                UserDetailRowView(label: "Company:", value: user.companyValue)
                UserDetailRowView(label: "Email:", value: user.emailValue)
                UserDetailRowView(label: "Address:", value: user.addressValue)
            }
            
            Section(header: Text("About").font(.headline)) {
                NavigationLink(destination: VStack {
                    Text(user.aboutValue)
                        .padding()
                    Spacer()
                        .navigationBarTitle("About", displayMode: .inline)
                }) {
                    Text(user.aboutValue)
                        .lineLimit(5)
                }
            }
            
            Section(header: Text("Friends").font(.headline)) {
                ForEach(user.friendsValue) { friend in
                    NavigationLink(destination: DetailView(user: self.findUser(withId: friend.idValue))) {
                        Text(friend.nameValue)
                    }
                }
            }
        }
        .navigationBarTitle(Text(user.nameValue), displayMode: .inline)
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
