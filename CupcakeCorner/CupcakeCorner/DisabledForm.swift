//
//  DisabledFomr.swift
//  CupcakeCorner
//
//  Created by Andres Vazquez on 2020-05-26.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct DisabledForm: View {
    @State private var username = ""
    @State private var email = ""
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            .disabled(disableForm)
        }
    }
}

struct DisabledForm_Previews: PreviewProvider {
    static var previews: some View {
        DisabledForm()
    }
}
