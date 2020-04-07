//
//  ContentView.swift
//  Animations
//
//  Created by Andres Vazquez on 2020-04-04.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationToShow: Int
    
    init(animationToShow: Int = 0) {
        _animationToShow = State(initialValue: animationToShow)
    }
    
    var animationContentView: AnyView {
        switch animationToShow {
        case 0:
            return AnyView(ImplicitAnimation())
        case 1:
            return AnyView(CustomAnimation())
        case 2:
            return AnyView(BindingAnimation())
        case 3:
            return AnyView(ExplicitAnimation())
        case 4:
            return AnyView(StackedAnimations())
        case 5:
            return AnyView(GestureAnimations())
        case 6:
            return AnyView(ShowHideAnimation())
        default:
            return AnyView(CustomTransition())
        }
    }
    
    var body: some View {
        VStack {
            animationContentView
            
            Button("Go to next animation") {
                self.animationToShow = (self.animationToShow + 1) % 8
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

// Animation 1: Custom Animations
struct CustomAnimation: View {
    @State private var springBtnAmount: CGFloat = 1
    @State private var durationBtnAmount: CGFloat = 1
    @State private var repeatForeverAmount: CGFloat = 1
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button("Spring") {
                    self.springBtnAmount += 1
                }
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(springBtnAmount)
                .animation(.interpolatingSpring(stiffness: 50, damping: 5))
                
                Button("with duration") {
                    self.durationBtnAmount += 1
                }
                .padding(50)
                .background(Color.orange)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(durationBtnAmount)
                .animation(Animation.easeInOut(duration: 2))
                
                Button("Reset Buttons to initial size") {
                    self.springBtnAmount = 1
                    self.durationBtnAmount = 1
                }
                .padding([.top, .bottom], 45)
                
                Button("RepeatForever") {
                    
                }
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.red)
                        .scaleEffect(repeatForeverAmount)
                        .opacity(Double(2 - repeatForeverAmount))
                        .animation(
                            Animation.easeOut(duration: 1)
                                .repeatForever(autoreverses: false)
                        )
                )
                    .onAppear {
                        self.repeatForeverAmount = 2
                }
            }
            .navigationBarTitle("Custom Animations")
        }
    }
}

// Animation 2: Binding Animation
struct BindingAnimation: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        NavigationView {
            VStack {
                Stepper("Scale amount", value: $animationAmount.animation(
                    Animation.easeInOut(duration: 1)
                        .repeatCount(3, autoreverses: true)
                ), in: 1...10)
                
                Spacer()
                
                Text("Animate Me")
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount)
                
                Spacer()
            }
            .navigationBarTitle("Binding Animation")
        }
    }
}

// Animation 3: Explicit Animation
struct ExplicitAnimation: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                Button("withAnimation") {
                    withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
                        self.animationAmount += 360
                    }
                }
                .padding(50)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
            }
            .navigationBarTitle("Explicit Animation")
        }
    }
}

// Animation 4: Stacked Animations
struct StackedAnimations: View {
    @State private var enabled = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Stacked") {
                    self.enabled.toggle()
                }
                .frame(width: 200, height: 200)
                .background(enabled ? Color.blue : Color.red)
                .animation(nil)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
                .animation(.interpolatingSpring(stiffness: 10, damping: 2))
            }
            .navigationBarTitle("Stacked Animations")
        }
    }
}

// Animation 5: Gestures Animation
struct GestureAnimations: View {
    @State private var dragAmount = CGSize.zero
    @State private var dragAmountText = CGSize.zero
    @State private var enabled = false
    var letters = Array("Hello SwiftUI")
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 300, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged { self.dragAmount = $0.translation }
                            .onEnded  { _ in
                                withAnimation(.spring()) {
                                    self.dragAmount = .zero
                                }
                            }
                    )
                
                Spacer()
                
                HStack(spacing: 0) {
                    ForEach(0..<letters.count) {
                        Text(String(self.letters[$0]))
                            .padding(5)
                            .font(.title)
                            .background(self.enabled ? Color.blue : Color.red)
                            .offset(self.dragAmountText)
                            .animation(Animation.default.delay(Double($0) / 20))
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { self.dragAmountText = $0.translation }
                        .onEnded { _ in
                            withAnimation {
                                self.dragAmountText = .zero
                                self.enabled.toggle()
                            }
                        }
                )
                
                Spacer()
            }
            .navigationBarTitle("Gesture Animations")
        }
    }
}

struct ShowHideAnimation: View {
    @State private var showRectangle = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(showRectangle ? "Hide Rectangle" : "Show Rectangle") {
                    withAnimation {
                        self.showRectangle.toggle()
                    }
                }
                
                if showRectangle {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 200, height: 200)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
            }
        .navigationBarTitle("Show & Hide Animation")
        }
    }
}


struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        self.modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct CustomTransition: View {
    @State private var showRectangle = false
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                Button(showRectangle ? "Hide Rectangle" : "Show Rectangle") {
                    withAnimation {
                        self.showRectangle.toggle()
                    }
                }
                
                if showRectangle {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 200, height: 200)
                        .transition(.pivot)
                }
            }
        .navigationBarTitle("Custom Transition")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView(animationToShow: 1)
            ContentView(animationToShow: 2)
            ContentView(animationToShow: 3)
            ContentView(animationToShow: 4)
            ContentView(animationToShow: 5)
            ContentView(animationToShow: 6)
            ContentView(animationToShow: 7)
        }
    }
}
