//
//  ContentView.swift
//  Challenges
//
//  Created by Andres Vazquez on 2020-04-07.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScoreAlert = false
    @State private var scoreAlertTitle = ""
    @State private var scoreAlertMessage = ""
    @State private var score = 0
    @State private var flagAnimations = [
        0: ["rotation": 0.0, "opacity": 1.0],
        1: ["rotation": 0.0, "opacity": 1.0],
        2: ["rotation": 0.0, "opacity": 1.0]
    ]
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number, name: self.countries[number])
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .opacity(self.flagAnimations[number]?["opacity"] ?? 1)
                            .rotation3DEffect(Angle(degrees: self.flagAnimations[number]?["rotation"] ?? 0), axis: (x: 0, y: 1, z: 0))
                            .overlay(self.getFlagOverlay(number))
                            .shadow(color: .black, radius: 2)
                    }
                }
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScoreAlert) {
            Alert(title: Text(scoreAlertTitle), message: Text(scoreAlertMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int, name: String) {
        if number == correctAnswer {
            score += 1
            scoreAlertTitle = "Correct"
            scoreAlertMessage = "Your score is \(score)"
        } else {
            score -= 1
            scoreAlertTitle = "Wrong"
            scoreAlertMessage = "That's the flag of \(name)"
        }
        
        withAnimation {
            for index in 0 ..< flagAnimations.count {
                if index == number && number == correctAnswer {
                    let rotationAmount = flagAnimations[index]?["rotation"] ?? 0
                    flagAnimations[index]?["rotation"] = rotationAmount + 360
                } else {
                    flagAnimations[index]?["opacity"] = 0.25
                }
            }
        }
        
        showingScoreAlert = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func getFlagOverlay(_ number: Int) -> some View {
        if showingScoreAlert && number != correctAnswer {
            return Color.red.clipShape(Capsule()).opacity(0.5)
        } else {
            return Color.clear.clipShape(Capsule()).opacity(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
