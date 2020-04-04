//
//  ContentView.swift
//  WordScramble
//
//  Created by Andres Vazquez on 2020-04-03.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var allWords = [String]()
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                
                Text("Score: \(score)")
                    .font(.headline)
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading: Button("New word") {
                self.rootWord = self.allWords.randomElement() ?? ""
                self.usedWords.removeAll(keepingCapacity: true)
                self.newWord = ""
                self.score = 0
            })
            .onAppear(perform: loadWords)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func loadWords() {
        if let wordsFileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let wordsList = try? String(contentsOf: wordsFileURL) {
                allWords = wordsList.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? ""
            }
        } else {
            fatalError("Could not load start.txt from bundle")
        }
    }
    
    private func addNewWord() {
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !word.isEmpty && isValid(word) {
            usedWords.insert(word, at: 0)
            newWord = ""
            score += word.count
        }
    }
    
    private func isValid(_ word: String) -> Bool {
        guard word.count >= 3 else {
            showAlert(title: "Too short", message: "Answers must be at least 3 letters long")
            return false
        }
        
        guard word != rootWord else {
            showAlert(title: "Same as root word", message: "You can't use the root word as an answer")
            return false
        }
        
        return isPossible(word) && isOriginal(word) && isReal(word)
    }
    
    private func isPossible(_ word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                showAlert(title: "Word not recognized", message: "You can't just make them up, you know!")
                return false
            }
        }
        
        return true
    }
    
    private func isOriginal(_ word: String) -> Bool {
        if usedWords.contains(word) {
            showAlert(title: "Word used already", message: "Be more original")
            return false
        }
        
        return true
    }
    
    private func isReal(_ word: String) -> Bool {
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = UITextChecker().rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        if misspelledRange.location != NSNotFound {
            showAlert(title: "Word not possible", message: "That isn't a real word")
            return false
        }
        
        return true
    }
    
    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
