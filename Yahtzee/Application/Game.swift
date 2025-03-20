//
//  Game.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/3/24.
//

import Foundation
import YahtzeeKit

enum DiceAction {
    case toggleDieHold
    case resetDice
    case rollDice(DiceValues, ScoreTuple?)
}

@Observable class Game {
    var diceCup: DiceCup

    var playerScorecard: Scorecard

    var opponentScorecard: Scorecard

    var opponent: Bot

    var selectedScoreType: ScoreType?

    var diceAction: DiceAction? = .resetDice

    var isRollInProgress = false

    var isGameOver = false

    var opponentLastTurn: ScoreTuple?

    var opponentDiceValues: DiceValues?

    var isOpponentTurn: Bool {
        playerScorecard.remainingTurns < opponentScorecard.remainingTurns
    }

    init(_ botSkillLevel: BotSkillLevel) {
        diceCup = DiceCup()
        playerScorecard = Scorecard()
        opponentScorecard = Scorecard()
        opponent = ConfigurableBot(skillLevel: botSkillLevel)
    }

    func playerScore() {
        guard let values = diceCup.values,
              let scoreType = selectedScoreType else {
            return
        }

        playerScorecard.score(values, scoreType: scoreType)
        playerScorecard.clearPossibleScores()
        selectedScoreType = nil
        diceCup.reset()
        diceAction = .resetDice
    }

    func opponentRoll() {
        let tuple = opponent.takeTurn(opponentScorecard)
        let values = diceCup.roll(tuple)

        diceAction = .rollDice(values, tuple)
    }

    func opponentScore(tuple: ScoreTuple, values: DiceValues) {
        opponentScorecard.score(tuple)
        opponentLastTurn = tuple
        opponentDiceValues = values

        diceCup.reset()
        diceAction = .resetDice

        if playerScorecard.isFull && opponentScorecard.isFull {
            isGameOver = true
        }
    }
}
