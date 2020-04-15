//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Andres Vazquez on 2020-04-12.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isFormVisible = false
    @State private var tables = 5
    @State private var numQuestionsIndex = 0
    @State private var numQuestions = ["5", "10", "20", "All"]
    @State private var questions = [Question]()
    @State private var currentQuestion = 0
    
    var body: some View {
        NavigationView {
            if isFormVisible {
                Group {
                    Form {
                        Stepper("Tables to practice: \(tables)", value: $tables, in: 1...12)
                        
                        VStack(alignment: .leading) {
                            Text("Numbet of Questions")
                            Picker("", selection: $numQuestionsIndex) {
                                ForEach(numQuestions, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Button("Start!") {
                            self.createQuestions()
                        }
                    }
                    .navigationBarTitle("Math x Fun")
                }
            } else {
                Group {
                    VStack {
                        ForEach(0..<questions.count, id: \.self) { index in
                            QuestionRow(question: self.questions[index], position: self.position(for: index))
//                                .offset(x: -10, y: CGFloat(index) * 75 - CGFloat(self.currentQuestion) * 75)
                        }
                    }
                    
                    Spacer()
                }
                .navigationBarTitle("Math x Fun")
                .onAppear(perform: createQuestions)
            }
        }
    }
    
    private func createQuestions() {
        let quantityOfQuestions: Int
        
        if numQuestions[numQuestionsIndex] == "All" {
            quantityOfQuestions = tables * 12
        } else {
            quantityOfQuestions = Int(numQuestions[numQuestionsIndex]) ?? 10
        }
        for _ in 1...quantityOfQuestions {
            questions.append(Question(highestTable: tables))
        }
    }
    
    private func position(for index: Int) -> Position {
        if index < currentQuestion {
            return .answered
        } else if index == currentQuestion {
            return .current
        } else {
            return .upcoming
        }
    }
}

struct QuestionRow: View {
    var question: Question
    var position: Position
    var positionColor: Color {
        switch position {
        case .answered:
            if question.result == userAnswer {
                return Color.green.opacity(0.8)
            } else {
                return Color.red.opacity(0.8)
            }
        case .current:
            return Color.blue.opacity(0.8)
            
        case .upcoming:
            return Color.black.opacity(0.3)
        }
    }
    @State private var userAnswer = ""
    
    var body: some View {
        HStack(spacing: 0) {
            if question.paddingAmount > 0 {
                Text(String(repeating: " ", count: question.paddingAmount))
            }
            
            Text(question.text)
                .fontWeight(.bold)
            TextfieldWithAccessoryView(text: $userAnswer, keyboardType: .numberPad)
                .frame(maxWidth: 75, maxHeight: 50)
                .background(positionColor)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .disabled(position == .current ? false : true)
        }
        .font(.system(size: 28, weight: .bold, design: .monospaced))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
