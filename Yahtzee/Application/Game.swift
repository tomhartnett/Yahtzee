//
//  Game.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/3/24.
//

import Foundation
import YahtzeeKit

enum DiceAction: Codable {
    case toggleDieHold
    case resetDice
    case rollDice(DiceValues, ScoreBox?)
}

struct Turn: Codable {
    let dice: DiceValues
    let score: ScoreBox
}

@Observable final class Game: Codable {
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

    init(botOpponent: Bot) {
        diceCup = DiceCup()
        playerScorecard = Scorecard()
        opponentScorecard = Scorecard()
        opponent = botOpponent
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
        let result = opponent.takeTurn(opponentScorecard)
        isRollInProgress = true
        diceAction = .rollDice(result.dice, result.score)
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

    func reset() {
        playerScorecard = Scorecard()
        opponentScorecard = Scorecard()
        diceCup.reset()
        diceAction = nil
        isRollInProgress = false
        isGameOver = false
        opponentLastTurn = nil
    }
}

private extension Game {
    enum CodingKeys: String, CodingKey {
        case diceCup
        case playerScorecard
        case opponentScorecard
        case opponentKind
        case selectedScoreType
        case diceAction
        case isRollInProgress
        case isGameOver
        case opponentLastTurn
    }
}

extension Game {
    private static let savedGameKey = "savedGame"

    static func loadSavedGame() -> Game? {
        guard let data = UserDefaults.standard.data(forKey: savedGameKey) else {
            return nil
        }

        return try? JSONDecoder().decode(Game.self, from: data)
    }

    static func deleteSavedGame() {
        UserDefaults.standard.removeObject(forKey: savedGameKey)
    }

    func save() {
        guard let data = try? JSONEncoder().encode(self) else {
            return
        }

        UserDefaults.standard.set(data, forKey: Self.savedGameKey)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(diceCup, forKey: .diceCup)
        try container.encode(playerScorecard, forKey: .playerScorecard)
        try container.encode(opponentScorecard, forKey: .opponentScorecard)
        try container.encode(opponent.kind, forKey: .opponentKind)
        try container.encode(selectedScoreType, forKey: .selectedScoreType)
        try container.encode(diceAction, forKey: .diceAction)
        try container.encode(isRollInProgress, forKey: .isRollInProgress)
        try container.encode(isGameOver, forKey: .isGameOver)
        try container.encode(opponentLastTurn, forKey: .opponentLastTurn)
    }

    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let opponentKind = try container.decode(BotKind.self, forKey: .opponentKind)

        self.init(botOpponent: opponentKind.makeBot())
        diceCup = try container.decode(DiceCup.self, forKey: .diceCup)
        playerScorecard = try container.decode(Scorecard.self, forKey: .playerScorecard)
        opponentScorecard = try container.decode(Scorecard.self, forKey: .opponentScorecard)
        selectedScoreType = try container.decodeIfPresent(ScoreType.self, forKey: .selectedScoreType)
        diceAction = try container.decodeIfPresent(DiceAction.self, forKey: .diceAction)
        isRollInProgress = try container.decode(Bool.self, forKey: .isRollInProgress)
        isGameOver = try container.decode(Bool.self, forKey: .isGameOver)
        opponentLastTurn = try container.decodeIfPresent(Turn.self, forKey: .opponentLastTurn)
    }
}

// MARK: - Sample for Previews

extension Game {
    static var previewSample: Game {
        Game(botOpponent: BotKind.default.makeBot())
    }
}
