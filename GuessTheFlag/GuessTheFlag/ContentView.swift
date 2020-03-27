//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Andres Vazquez on 2020-03-26.
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
        
        showingScoreAlert = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
