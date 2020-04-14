//
//  Question.swift
//  MultiplicationTables
//
//  Created by Andres Vazquez on 2020-04-12.
//  Copyright © 2020 Andavazgar. All rights reserved.
//



struct Question {
    var text: String
    var result: String
    var paddingAmount = 0
    
    init(highestTable: Int) {
        let firstNumber = Int.random(in: 1...highestTable)
        let secondNumber = Int.random(in: 1...12)
        
        text = "\(firstNumber) x \(secondNumber) = "
        result = "\(firstNumber * secondNumber)"
        
        paddingAmount = 10 - text.count
    }
}
