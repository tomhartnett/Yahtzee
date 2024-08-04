//
//  Game.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/3/24.
//

import Foundation
import YahtzeeKit

@Observable class Game {
    var diceCup: DiceCup

    var playerScorecard: Scorecard

    var opponentScorecard: Scorecard

    var selectedScoreType: ScoreType?

    let opponent = RandomBot()

    init() {
        diceCup = DiceCup()
        playerScorecard = Scorecard()
        opponentScorecard = Scorecard()
    }

    func newGame() {
        diceCup.reset()
        playerScorecard = Scorecard()
        opponentScorecard = Scorecard()
    }

    func playerScore() {
        guard let values = diceCup.values,
              let scoreType = selectedScoreType else {
            return
        }

        playerScorecard.score(values, scoreType: scoreType)
        diceCup.reset()
        selectedScoreType = nil
    }

    func opponentTurn() {
        let tuple = opponent.takeTurn(opponentScorecard)
        opponentScorecard.score(tuple)
    }
}
