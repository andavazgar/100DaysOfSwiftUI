//
//  ContentView.swift
//  Animations
//
//  Created by Andres Vazquez on 2020-04-04.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationToShow = 0
    
    var animationContentView: some View {
        switch animationToShow {
        case 0:
            return ImplicitAnimation()
        case 1:
            return CustomAnimation()
        case 2:
            return ImplicitAnimation()
        default:
            return ImplicitAnimation()
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            animationContentView
            
            Button("Go to next animation") {
                self.animationToShow = (self.animationToShow + 1) % 4
            }
        }
    }
}

// Animation 0: Implicit Animation
struct ImplicitAnimation: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Tap Me") {
                    self.animationAmount += 1
                }
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount)
//                .blur(radius: (animationAmount - 1) * 3)
                .animation(.default)
            }
            .navigationBarTitle("Implicit Animation")
        }
    }
}

// Animation 1: Custom Animation
struct CustomAnimation: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Tap Me") {
                    self.animationAmount += 1
                }
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount)
                .animation(Animation.easeInOut(duration: 1).repeatCount(3, autoreverses: true))
            }
            .navigationBarTitle("Custom Animation")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
