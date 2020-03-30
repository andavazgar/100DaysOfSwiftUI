//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Andres Vazquez on 2020-03-29.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct AlertItem: Identifiable {
    enum AlertType {
        case player, gameOver
    }
    
    var id: AlertType
}

struct ContentView: View {
    let moves = ["✊🏻", "✋🏻", "✌🏻"]
    @State private var chosenMove = ""
    @State private var shouldWin = false
    @State private var score = 0
    @State private var scoreChange = 0
    @State private var round = 1
    let numOfRounds = 10
    
    @State private var showAlert: AlertItem?
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
        .alert(item: $showAlert) { alertToShow in
            switch alertToShow.id {
            case .player:
                return Alert(title: Text(self.alertTitle), message: Text(self.alertMessage), dismissButton: .default(Text("OK")) {
                    self.score += self.scoreChange

                    if self.round < self.numOfRounds {
                        self.round += 1
                        self.decideMoveAndObjective()
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.showAlert = AlertItem(id: .gameOver)
                        }
                    }
                })
            case .gameOver:
                return Alert(title: Text("End of game"), message: Text("Your final score is \(score)/\(numOfRounds)"), dismissButton: .default(Text("Play Again")) {
                    self.restartGame()
                })
            }
        }
    }
    
    private func decideMoveAndObjective() {
        chosenMove = moves.randomElement() ?? ""
        shouldWin = Bool.random()
    }
    
    private func evaluate(playerMove: String) {
        if let position = moves.firstIndex(of: chosenMove) {
            if shouldWin {
                let correctMove = moves[(position + 1) % moves.count]
                
                if correctMove == playerMove {
                    alertTitle = "Correct"
                    alertMessage = "\(correctMove) beats \(moves[position])"
                    scoreChange = 1
                } else {
                    alertTitle = "Wrong"
                    alertMessage = "You should have chosen \(moveName(for: correctMove)) (\(correctMove))"
                    scoreChange = -1
                }
                
            } else {
                let correctMove = moves[(position - 1 + moves.count) % moves.count]
                
                if correctMove == playerMove {
                    alertTitle = "Correct"
                    alertMessage = "\(correctMove) loses to \(moves[position])"
                    scoreChange = 1
                } else {
                    alertTitle = "Wrong"
                    alertMessage = "You should have chosen \(moveName(for: correctMove)) (\(correctMove))"
                    scoreChange = -1
                }
            }
            
            showAlert = AlertItem(id: .player)
        }
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
    
    private func restartGame() {
        round = 1
        score = 0
        decideMoveAndObjective()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
