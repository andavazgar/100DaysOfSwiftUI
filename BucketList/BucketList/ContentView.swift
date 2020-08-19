//
//  ContentView.swift
//  BucketList
//
//  Created by Andres Vazquez on 2020-08-13.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import LocalAuthentication
import SwiftUI

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var showingError = false
    @State private var errorAlert = Alert(title: Text(""))
    
    var body: some View {
        VStack {
            if isUnlocked {
                PlacesView()
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .alert(isPresented: $showingError) {
            errorAlert
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate yourself to unlock your places.") { (success, error) in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.errorAlert = Alert(title: Text("Error"), message: Text("Authentication failed"), dismissButton: .default(Text("OK")))
                        self.showingError = true
                    }
                }
            }
        } else {
            self.errorAlert = Alert(title: Text("Error"), message: Text("No biometrics"), dismissButton: .default(Text("OK")))
            self.showingError = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
