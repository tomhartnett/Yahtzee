//
//  LuckBot.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 8/24/24.
//

import Foundation

public class LuckBot: Bot {
    public init() {}

    public func takeTurn(_ scorecard: Scorecard) -> TurnResult {
        var diceCup = DiceCup()
        let scoreType = scorecard.randomEmpty()
        let scoreValue: Int

        let allOrNothingScoreTypes: [ScoreType] = [.yahtzee, .largeStraight, .smallStraight, .fullHouse]
        let luckFactor = Int.random(in: 0...4)
        let isLucky = luckFactor != 0
        if !isLucky && allOrNothingScoreTypes.contains(scoreType) {
            let score = ScoreBox(scoreType: scoreType, value: 0)
            let values = diceCup.rollZero(for: scoreType)
            return TurnResult(score: score, dice: values)
        }

        let topSectionMultiplier = Int.random(in: 2...4)

        var threeOrFourOfKindExtras = [1, 2, 3, 4, 5, 6]

        switch scoreType {
        case .ones:
            scoreValue = topSectionMultiplier

        case .twos:
            scoreValue = topSectionMultiplier * 2

        case .threes:
            scoreValue = topSectionMultiplier * 3

        case .fours:
            scoreValue = topSectionMultiplier * 4

        case .fives:
            scoreValue = topSectionMultiplier * 5

        case .sixes:
            scoreValue = topSectionMultiplier * 6

        case .threeOfAKind:
            let random1 = Int.random(in: 1...6)
            threeOrFourOfKindExtras.removeAll(where: { $0 == random1 })
            let random2 = threeOrFourOfKindExtras.randomElement()!
            let random3 = threeOrFourOfKindExtras.randomElement(where: { $0 != random2 })!
            scoreValue = random1 * 3 + random2 + random3

        case .fourOfAKind:
            let random1 = Int.random(in: 1...6)
            threeOrFourOfKindExtras.removeAll(where: { $0 == random1 })
            let random2 = threeOrFourOfKindExtras.randomElement()!
            scoreValue = random1 * 4 + random2

        case .fullHouse:
            scoreValue = 25

        case .smallStraight:
            scoreValue = 30

        case .largeStraight:
            scoreValue = 40

        case .yahtzee:
            // Yahtzees should be rare, so additional luck needed.
            let random = Int.random(in: 0...1)
            scoreValue = random == 1 ? 50 : 0

        case .chance:
            scoreValue = Int.random(in: 6...29)
        }

        let scoreBox = ScoreBox(scoreType: scoreType, value: scoreValue)
        let values = diceCup.roll(scoreBox)

        // Check for randomly better score option
        if let betterScore = checkForBetterScoreType(
            scoreType: scoreType,
            dice: values,
            scoreCard: scorecard
        ) {
            return TurnResult(score: betterScore, dice: values)
        } else {
            return TurnResult(score: scoreBox, dice: values)
        }
    }

    private func checkForBetterScoreType(
        scoreType: ScoreType,
        dice: DiceValues,
        scoreCard: Scorecard
    ) -> ScoreBox? {
        if dice.isYahtzee && scoreCard[.yahtzee].isEmpty && scoreType != .yahtzee {
            return ScoreBox(scoreType: .yahtzee, value: 50)
        } else if dice.isLargeStraight && scoreCard[.largeStraight].isEmpty && scoreType != .largeStraight {
            return ScoreBox(scoreType: .largeStraight, value: 40)
        } else if dice.isSmallStraight && scoreCard[.smallStraight].isEmpty && scoreType != .smallStraight {
            return ScoreBox(scoreType: .smallStraight, value: 30)
        } else if dice.isFullHouse && scoreCard[.fullHouse].isEmpty && scoreType != .fullHouse {
            return ScoreBox(scoreType: .fullHouse, value: 25)
        } else {
            return nil
        }
    }
}
