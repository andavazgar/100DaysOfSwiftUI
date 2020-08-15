//
//  BiometricsView.swift
//  BucketList
//
//  Created by Andres Vazquez on 2020-08-14.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import LocalAuthentication
import SwiftUI

struct BiometricsView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "We need to unlock your data.") { (success, error) in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        print("Failed authentication: \(error?.localizedDescription ?? "")")
                    }
                }
            }
        } else {
            print("Device doesn't have biometric authentication.")
        }
    }
}

struct BiometricsView_Previews: PreviewProvider {
    static var previews: some View {
        BiometricsView()
    }
}
