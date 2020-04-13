//
//  Question.swift
//  MultiplicationTables
//
//  Created by Andres Vazquez on 2020-04-12.
//  Copyright © 2020 Andavazgar. All rights reserved.
//



struct Question {
    var firstNumber: Int
    var secondNumber: Int
    var result: Int {
        firstNumber * secondNumber
    }
    var text: String {
        "\(firstNumber) x \(secondNumber) = "
    }
}
