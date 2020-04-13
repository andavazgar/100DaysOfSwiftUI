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
    @State private var answer = ""
    
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
                    HStack {
                        Text(questions[currentQuestion].text)
                        TextField("ANswer", text: $answer)
                            .keyboardType(.numberPad)
                    }
                }
                .navigationBarTitle("")
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
        for _ in 0...quantityOfQuestions {
            questions.append(Question(firstNumber: Int.random(in: 1...tables), secondNumber: Int.random(in: 1...12)))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
