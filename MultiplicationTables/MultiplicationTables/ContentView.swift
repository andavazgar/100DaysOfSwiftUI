//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Andres Vazquez on 2020-04-12.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var isFormVisible = true
    @State private var tables = 1
    @State private var numQuestionsIndex = 0
    @State private var numQuestions = ["5", "10", "20", "All"]
    @State private var questions = [Question]()
    @State private var currentQuestion = 0
    private var score: Int {
        return questions.filter { $0.result == $0.userAnswer }.count
    }
    private let appTitle = "Math × Fun"
    
    var body: some View {
        NavigationView {
            if isFormVisible {
                Group {
                    Form {
                        HStack {
                            Text("Practice tables up to:")
                            Stepper(value: $tables, in: 1...12) {
                                Text("\(tables)")
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.vertical, 10)
                        
                        VStack(alignment: .leading) {
                            Text("Numbet of questions:")
                            Picker("", selection: $numQuestionsIndex) {
                                ForEach(0..<numQuestions.count, id: \.self) {
                                    Text(self.numQuestions[$0])
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        .padding(.vertical, 10)
                        
                        Button("Start!") {
                            withAnimation {
                                self.isFormVisible = false
                            }
                        }
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                    }
                    .navigationBarTitle(appTitle)
                }
            } else {
                Group {
                    ZStack {
                        ForEach(0..<questions.count, id: \.self) { index in
                            QuestionRow(question: self.questions[index], position: self.position(for: index))
                                .offset(x: -10, y: CGFloat(index) * 75 - CGFloat(self.currentQuestion) * 75)
                        }
                        
                        GeometryReader { metrics in
                            VStack {
                                Color(.systemBackground)
                                    .frame(height: metrics.size.height * 0.25)
                                    .edgesIgnoringSafeArea(.all)
                            }
                            Spacer()
                        }
                        
                        Text("Score: \(score)")
                        .padding()
                        .background(Capsule().fill(Color.primary.opacity(0.2)))
                        .font(.system(size: 25, weight: .bold, design: .default))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding()
                        .offset(x: 0, y: -75)
                    }
                }
                .navigationBarTitle(appTitle)
                .onAppear(perform: createQuestions)
                .onReceive(NotificationCenter.default.publisher(for: .submitAnswer)) { notification in
                    if let answer = notification.object as? String {
                        self.questions[self.currentQuestion].userAnswer = answer
                    }
                    withAnimation {
                        self.currentQuestion += 1
                    }
                }
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
            if question.result == question.userAnswer {
                return Color.green.opacity(0.8)
            } else {
                return Color.red.opacity(0.8)
            }
        case .current:
            return Color.blue.opacity(0.8)
            
        case .upcoming:
            return Color.primary.opacity(0.2)
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            if question.paddingAmount > 0 {
                Text(String(repeating: " ", count: question.paddingAmount))
            }
            
            Text(question.text)
                .fontWeight(.bold)
            
            TextfieldWithAccessoryView(placeholder: "?", keyboardType: .numberPad, position: position)
                .frame(width: 75, height: 50)
                .background(positionColor)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .disabled(position == .current ? false : true)
        }
        .font(.system(size: 28, weight: .bold, design: .monospaced))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView().colorScheme(.dark)
        }
    }
}
