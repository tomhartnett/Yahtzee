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
    case rollDice(DiceValues, ScoreBox?)
}

struct Turn {
    let dice: DiceValues
    let score: ScoreBox
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

    var opponentLastTurn: Turn?

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
        guard let dice = diceCup.values,
              let scoreType = selectedScoreType else {
            return
        }

        playerScorecard.score(dice, scoreType: scoreType)
        playerScorecard.clearPossibleScores()
        selectedScoreType = nil
        diceCup.remainingRolls = 0
        diceAction = .resetDice
    }

    func opponentRoll() {
        let score = opponent.takeTurn(opponentScorecard)
        let dice = diceCup.roll(score)
        isRollInProgress = true
        diceAction = .rollDice(dice, score)
    }

    func opponentScore(score: ScoreBox, values: DiceValues) {
        opponentScorecard.score(score)
        opponentLastTurn = Turn(dice: values, score: score)

        diceCup.reset()
        diceAction = .resetDice

        if playerScorecard.isFull && opponentScorecard.isFull {
            isGameOver = true
        }
    }
}
