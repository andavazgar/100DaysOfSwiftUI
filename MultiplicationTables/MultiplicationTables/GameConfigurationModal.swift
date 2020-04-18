//
//  MathForm.swift
//  MultiplicationTables
//
//  Created by Andres Vazquez on 2020-04-17.
//  Copyright © 2020 Andavazgar. All rights reserved.
//

import SwiftUI

struct GameConfigurationModal: View {
    @State private var tables = 1
    @State private var numQuestionsIndex = 0
    @State private var numQuestions = ["5", "10", "20", "All"]
    
    @Binding var questions: [Question]
    @Binding var isFormVisible: Bool
    
    var body: some View {
        NavigationView {
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
                    Text("Number of questions:")
                    Picker("", selection: $numQuestionsIndex) {
                        ForEach(0..<numQuestions.count, id: \.self) {
                            Text(self.numQuestions[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding(.vertical, 10)
                
                Button("Start!") {
                    self.createQuestions()
                    
                    withAnimation {
                        self.isFormVisible = false
                    }
                }
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
            }
            .navigationBarTitle("Game Configuration")
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
}

struct MathForm_Previews: PreviewProvider {
    static var previews: some View {
        GameConfigurationModal(questions: .constant([Question]()), isFormVisible: .constant(true))
    }
}
