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
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75))
                
                // Stack of cards
                if isActive && cards.count > 0 {
                    ZStack {
                        ForEach(0..<cards.count, id: \.self) { index in
                            CardView(card: cards[index]) { isCorrect in
                                
                                if isCorrect {
                                    self.gameStats.correct += 1
                                    withAnimation {
                                        self.removeCard(at: index)
                                    }
                                } else {
                                    self.gameStats.incorrect += 1
                                    withAnimation {
                                        self.removeCard(at: index, wasCorrect: false)
                                    }
                                }
                            }
                            .stacked(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                            .accessibility(hidden: index < cards.count - 1)
                        }
                    }
                    .allowsHitTesting(timeRemaining > 0)
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
                            
                            Button("Start Again", action: resetCards)
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
                    .sheet(isPresented: $showingSettingsScreen) {
                        SettingsView(retryMistakes: $retryMistakes)
                    }
                    
                    Spacer()
                    
                    AppButton(action: {
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus.circle")
                    }
                    .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
                        EditCardsView()
                    }
                }
                
                Spacer()
            }
            
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        AppButton(action: {
                            withAnimation {
                                self.removeCard(at: cards.count - 1, wasCorrect: false)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        
                        Spacer()
                        
                        AppButton(action: {
                            withAnimation {
                                self.removeCard(at: cards.count - 1)
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
        .onAppear(perform: resetCards)
    }
    
    
    func startGame() {
        guard cards.count > 0 else { return }
        
        gameStats.deckSize = cards.count
        isActive = true
        _ = timer.connect()
    }
    
    func removeCard(at index: Int, wasCorrect: Bool = true) {
        guard index >= 0 else { return }
        
        let card = cards[index]
        cards.remove(at: index)
        
        if wasCorrect == false && retryMistakes {
            cards.insert(card, at: 0)
        }
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = totalGameTime
        timer = Timer.publish(every: 1, on: .main, in: .common)
        _ = timer.connect()
        loadData()
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
