//
//  Card.swift
//  Flashzilla
//
//  Created by Andres Vazquez on 2020-10-19.
//

import Foundation

struct Card: Codable, Identifiable {
    let id = UUID()
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "What is the capital of the United States?", answer: "Washington D.C.")
}
