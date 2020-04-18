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
    @State private var questions = [Question]()
    @State private var currentQuestion = 0
    private var score: Int {
        return questions.filter { $0.result == $0.userAnswer }.count
    }
    
    init(questions: [Question] = [Question]()) {
        self._questions = State(initialValue: questions)
    }
    
    var body: some View {
        NavigationView {
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
            .navigationBarTitle("Math × Fun")
            .onAppear { self.isFormVisible = true }
            .sheet(isPresented: $isFormVisible, onDismiss: {
                if self.questions.isEmpty {
                    self.isFormVisible = true
                }
            }, content: {
                GameConfigurationModal(questions: self.$questions, isFormVisible: self.$isFormVisible)
            })
            .onReceive(NotificationCenter.default.publisher(for: .submitAnswer)) { notification in
                if let answer = notification.object as? String {
                    self.questions[self.currentQuestion].userAnswer = answer
                }
                withAnimation {
                    self.currentQuestion += 1
                }
                
                if self.currentQuestion > self.questions.count {
                    print("The gane is done")
                }
            }
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
    static var questions: [Question] = {
        var questions = [Question]()
        for _ in 0..<10 {
            questions.append(Question(highestTable: 12))
        }
        return questions
    }()
    
    static var previews: some View {
        Group {
            ContentView(questions: questions)
            ContentView(questions: questions).colorScheme(.dark)
        }
    }
}
