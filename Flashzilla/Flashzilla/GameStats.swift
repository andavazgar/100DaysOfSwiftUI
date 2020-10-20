//
//  GameStats.swift
//  Flashzilla
//
//  Created by Andres Vazquez on 2020-10-28.
//

import Foundation

struct GameStats {
    var deckSize = 0
    var correct = 0
    var incorrect = 0
    var numCardsReviewed: Int {
        return correct + incorrect
    }
}
