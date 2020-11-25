//
//  ContentView.swift
//  Flashzilla
//
//  Created by Andres Vazquez on 2020-09-30.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var cards = [Card]()
    @State private var isActive = false
    @State private var retryMistakes = false
    @State private var totalGameTime = 100
    @State private var timeRemaining = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common)
    @State private var gameStats = GameStats()
    
    
    @State private var showingSettingsScreen = false
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Stack of cards
                if isActive && cards.count > 0 {
                    ZStack {
                        ForEach(cards) { card in
                            let index = self.getCardIndex(card)
                            
                            CardView(card: card, shouldReset: retryMistakes) { isCorrect in
                                if isCorrect {
                                    self.gameStats.correct += 1
                                    withAnimation {
                                        self.removeCard(wasCorrect: true)
                                    }
                                } else {
                                    self.gameStats.incorrect += 1
                                    withAnimation {
                                        self.removeCard(wasCorrect: false)
                                    }
                                }
                            }
                            .stacked(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                            .accessibility(hidden: index < cards.count - 1)
                        }
                    }
                    .allowsHitTesting(timeRemaining > 0)
                    .padding(.top, 20)
                }
                
                if !isActive {
                    // Start Game button
                    if cards.count > 0 && timeRemaining == totalGameTime {
                        Button("Start Game", action: startGame)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                    }
                    
                    // End of Game & Stats Screen
                    if (cards.count == 0 && timeRemaining < totalGameTime) || timeRemaining == 0 {
                        VStack {
                            HStack(spacing: 15) {
                                VStack(alignment: .leading) {
                                    Text("Cards:")
                                    Text("Reviewed:")
                                    Text("Correct:")
                                    Text("Incorrect:")
                                }
                                
                                VStack(alignment: .trailing) {
                                    Text("\(gameStats.deckSize)")
                                    Text("\(gameStats.numCardsReviewed)")
                                    Text("\(gameStats.correct)")
                                    Text("\(gameStats.incorrect)")
                                }
                            }
                            .padding(.vertical, 2)
                            .padding(.horizontal)
                            
                            Spacer()
                                .frame(maxHeight: 20)
                            
                            Button("Start Again", action: restartGame)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .clipShape(Capsule())
                        }
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                }
            }
            
            VStack {
                HStack {
                    AppButton(action: {
                        self.showingSettingsScreen = true
                    }) {
                        Image(systemName: "gear")
                    }
                    .sheet(isPresented: $showingSettingsScreen, onDismiss: {
                        loadGame()
                    }) {
                        SettingsView(retryMistakes: $retryMistakes)
                    }
                    
                    AppLabel("Retry cards: \(retryMistakes ? "ON" : "OFF")", color: retryMistakes ? .green : .red)
                        .font(.title3)
                        .offset(x: -15, y: 0)
                    
                    Spacer()
                    
                    AppButton(action: {
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus.circle")
                    }
                    .sheet(isPresented: $showingEditScreen, onDismiss: loadGame) {
                        EditCardsView()
                    }
                }
                
                Spacer()
                
                if cards.count > 0 {
                    AppLabel("\(isActive ? "Cards remaining" : "Deck size"): \(cards.count)")
                        .font(.title2)
                }
            }
            
            VStack {
                AppLabel("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .padding(28)
                
                Spacer()
            }
            
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        AppButton(action: {
                            withAnimation {
                                self.removeCard(wasCorrect: false)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        
                        Spacer()
                        
                        AppButton(action: {
                            withAnimation {
                                self.removeCard(wasCorrect: true)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer, perform: { _ in
            guard isActive else {
                timer.connect().cancel()
                return
            }
            
            if timeRemaining > 0 && cards.isEmpty == false {
                timeRemaining -= 1
            } else {
                isActive = false
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
            isActive = false
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification), perform: { _ in
            if cards.isEmpty == false && gameStats.numCardsReviewed > 0 {
                isActive = true
            }
        })
        .onAppear(perform: loadGame)
    }
    
    
    func startGame() {
        guard cards.count > 0 else { return }
        
        isActive = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
        _ = timer.connect()
    }
    
    func restartGame() {
        loadGame()
        
        isActive = true
        timer = Timer.publish(every: 1, on: .main, in: .common)
        _ = timer.connect()
    }
    
    func removeCard(wasCorrect: Bool) {
        let card = cards.removeLast()
        
        if wasCorrect == false && retryMistakes {
            cards.insert(card, at: 0)
        }
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func getCardIndex(_ card: Card) -> Int {
        return cards.firstIndex { $0.id == card.id } ?? 0
    }
    
    func loadGame() {
        timeRemaining = totalGameTime
        loadData()
        gameStats = GameStats(deckSize: cards.count)
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
