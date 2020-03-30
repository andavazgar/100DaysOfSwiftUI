//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Andres Vazquez on 2020-03-29.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let moves = ["✊🏻", "✋🏻", "✌🏻"]
    @State private var chosenMove = ""
    @State private var shouldWin = false
    @State private var score = 0
    @State private var scoreChange = 0
    @State private var round = 1
    let numOfRounds = 10
    @State private var gameOver = false
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Round: \(round)/\(numOfRounds)")
                Spacer()
                Text("Score: \(score)")
            }
            .padding(20)
            .font(.system(size: 22))
            
            Spacer()
            
            Group {
                Text("\(chosenMove)")
                    .font(.system(size: 120))
                    .padding()
                
                HStack(spacing: 5) {
                    Text("Objective:")
                    Text("\(shouldWin ? "WIN" : "LOSE")")
                        .foregroundColor(shouldWin ? .green : .red)
                }
                .font(.system(size: 22, weight: .bold, design: .default))
            }
            
            Spacer()
            
            HStack {
                ForEach(moves, id: \.self) { move in
                    Button(action: {
                        self.evaluate(playerMove: move)
                    }) {
                        VStack {
                            Text(move)
                                .font(.system(size: 70))
                            Text(self.moveName(for: move))
                                .font(.system(size: 22))
                        }
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 44)
            }
            
            Spacer()
        }
        .onAppear(perform: decideMoveAndObjective)
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                self.round += 1
                self.score += self.scoreChange
                
                if self.gameOver == false {
                    self.decideMoveAndObjective()
                }
            })
        }
    }
    
    private func decideMoveAndObjective() {
        if round > numOfRounds {
            gameOver = true
            alertTitle = "End of the game"
            alertMessage = "Your final score is \(score)/\(numOfRounds)"
            showAlert = true
        } else {
            chosenMove = moves.randomElement() ?? ""
            shouldWin = Bool.random()
        }
    }
    
    private func evaluate(playerMove: String) {
        switch chosenMove {
        case "✊🏻":
            if playerMove == "✊🏻" {
                alertTitle = "Wrong"
                alertMessage = "✊🏻 and ✊🏻 results in a draw, not a \(shouldWin ? "WIN" : "LOSE")."
                
                scoreChange = -1
            } else if (shouldWin && playerMove == "✋🏻") || (!shouldWin && playerMove == "✌🏻") {
                alertTitle = "Correct"
                alertMessage = shouldWin ? "✋🏻 beats ✊🏻" : "✊🏻 beats ✌🏻"
                
                scoreChange = 1
            } else {
                alertTitle = "Wrong"
                alertMessage = shouldWin ? "You should have chosedn ✋🏻" : "You should have chosen ✌🏻"
                
                scoreChange = -1
            }
            
        case "✋🏻":
            if playerMove == "✋🏻" {
                alertTitle = "Wrong"
                alertMessage = "✋🏻 and ✋🏻 results in a draw, not a \(shouldWin ? "WIN" : "LOSE")."
                
                scoreChange = -1
            } else if (shouldWin && playerMove == "✌🏻") || (!shouldWin && playerMove == "✊🏻") {
                alertTitle = "Correct"
                alertMessage = shouldWin ? "✌🏻 beats ✋🏻" : "✋🏻 beats ✊🏻"
                
                scoreChange = 1
            } else {
                alertTitle = "Wrong"
                alertMessage = shouldWin ? "You should have chosedn ✌🏻" : "You should have chosen ✊🏻"
                
                scoreChange = -1
            }
        default:
            // Scissors (✌🏻)
            if playerMove == "✌🏻" {
                alertTitle = "Wrong"
                alertMessage = "✌🏻 and ✌🏻 results in a draw, not a \(shouldWin ? "WIN" : "LOSE")."
                
                scoreChange = -1
            } else if (shouldWin && playerMove == "✊🏻") || (!shouldWin && playerMove == "✋🏻") {
                alertTitle = "Correct"
                alertMessage = shouldWin ? "✊🏻 beats ✌🏻" : "✌🏻 beats ✋🏻"
                
                scoreChange = 1
            } else {
                alertTitle = "Wrong"
                alertMessage = shouldWin ? "You should have chosedn ✊🏻" : "You should have chosen ✋🏻"
                
                scoreChange = -1
            }
        }
        
        showAlert = true
    }
    
    private func moveName(for moveEmoji: String) -> String {
        switch moveEmoji {
        case "✊🏻":
            return "Rock"
        case "✋🏻":
            return "Paper"
        default:
            return "Scissors"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
