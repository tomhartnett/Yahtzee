//
//  BotTests.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 8/6/24.
//

@testable import YahtzeeKit
import Testing

struct BetterBotTests {
    @Test func testYahtzee() {
        // Given
        let bot = BetterBot()
        let scorecard = Scorecard()

        // When
        let turn1 = bot.takeTurn(
            scorecard,
            with: DiceValues(
                .one,
                .one,
                .one,
                .one,
                .one
            )
        )

        // Then
        #expect(turn1.type == .yahtzee)
    }

    @Test func testLargeStraight() {
        // Given
        let bot = BetterBot()
        let scorecard = Scorecard()

        // When
        let turn1 = bot.takeTurn(
            scorecard,
            with: DiceValues(
                .one,
                .two,
                .three,
                .four,
                .five
            )
        )

        // Then
        #expect(turn1.type == .largeStraight)
    }

    @Test func testSmallOrLargeStraight() {
        // Given
        let bot = BetterBot()
        let scorecard = Scorecard()

        // When
        let turn1 = bot.takeTurn(
            scorecard,
            with: DiceValues(
                .one,
                .one,
                .two,
                .three,
                .four
            )
        )

        // Then
        #expect(turn1.type == .smallStraight || turn1.type == .largeStraight)
    }

    @Test func fourOfAKind() {
        // Given
        let bot = BetterBot()
        var scorecard = Scorecard()

        // WORKAROUND: sorting logic will return `threeOfAKind` first if not already scored.
        scorecard.score(ScoreTuple(type: .threeOfAKind, value: 0))

        // When
        let turn1 = bot.takeTurn(
            scorecard,
            with: DiceValues(
                .five,
                .one,
                .five,
                .five,
                .five
            )
        )

        // Then
        #expect(turn1.type == .fourOfAKind || turn1.type == .yahtzee)

        print(turn1.type)
    }

    @Test func fullGame() {
        // Given
        let bot = BetterBot()
        var scorecard = Scorecard()

        for turn in 0...12 {
            let tuple = bot.takeTurn(scorecard)

            print("Turn \(turn): \(tuple.type)\t\(tuple.valueOrZero)")

            scorecard.score(tuple)
        }

        var isGameComplete = true
        for scoreType in ScoreType.allCases {
            if scorecard.isScoreEmpty(scoreType) {
                isGameComplete = false
            }
        }

        #expect(isGameComplete == true)

        print("Upper: \(scorecard.upperTotal)")
        print("Bonus: \(scorecard.upperBonus)")
        print("Lower: \(scorecard.lowerTotal)")
        print("Total: \(scorecard.totalScore)")
    }
}
