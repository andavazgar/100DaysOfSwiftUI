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
    
    @State private var score = 0
    @State private var chosenFlag: Int?
    @State private var wrongFlagMessage = ""
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
                
                HStack {
                    Text("Score:")
                    
                    if chosenFlag != nil {
                        Text("\(score)")
                            .foregroundColor(chosenFlag == correctAnswer ? Color.green : Color.red)
                    } else {
                        Text("\(score)")
                    }
                }
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .bold))
                .padding(.top, 50)
                
                if chosenFlag != nil {
                    Text(wrongFlagMessage)
                        .foregroundColor(.red)
                        .font(.system(size: 20, weight: .bold))
                    
                    
                    Button("Next Question") {
                        self.askNextQuestion()
                    }
                }
                Spacer()
            }
        }
    }
    
    func flagTapped(_ number: Int, name: String) {
        chosenFlag = number
        
        withAnimation {
            for index in 0 ..< flagAnimations.count {
                if index == chosenFlag {
                    if chosenFlag == correctAnswer {
                        score += 1
                        
                        let rotationAmount = flagAnimations[index]?["rotation"] ?? 0
                        flagAnimations[index]?["rotation"] = rotationAmount + 360
                    } else {
                        score -= 1
                        
                        wrongFlagMessage = "That's the flag of \(name)"
                    }
                }
                
                if index != correctAnswer {
                    flagAnimations[index]?["opacity"] = 0.25
                }
            }
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func askNextQuestion() {
        chosenFlag = nil
        wrongFlagMessage = ""
        resetFlagAnimations()
        askQuestion()
    }
    
    func getFlagOverlay(_ number: Int) -> some View {
        if let chosenFlag = chosenFlag, number == chosenFlag && number != correctAnswer {
            return Color.red.clipShape(Capsule()).opacity(0.5)
        } else {
            return Color.clear.clipShape(Capsule()).opacity(1)
        }
    }
    
    func resetFlagAnimations() {
        for index in 0 ..< flagAnimations.count {
            flagAnimations[index]?["opacity"] = 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
