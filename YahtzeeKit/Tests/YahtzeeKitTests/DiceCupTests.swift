//
//  DiceCupTests.swift
//  YahtzeeTests
//
//  Created by Tom Hartnett on 6/18/24.
//

@testable import YahtzeeKit
import XCTest

final class DiceCupTests: XCTestCase {
    func test_not_yet_rolled() {
        // Given
        let cup = DiceCup()

        // Then
        XCTAssertNil(cup.values)
        XCTAssertEqual(cup.remainingRolls, 3)
    }

    func test_remainingRolls() {
        // Given
        var cup = DiceCup()

        // Then
        XCTAssertNil(cup.values)
        XCTAssertEqual(cup.remainingRolls, 3)

        // When
        cup.roll()

        // Then
        XCTAssertNotNil(cup.values)
        XCTAssertEqual(cup.remainingRolls, 2)

        // When
        cup.roll()

        // Then
        XCTAssertNotNil(cup.values)
        XCTAssertEqual(cup.remainingRolls, 1)

        // When
        cup.roll()

        // Then
        XCTAssertNotNil(cup.values)
        XCTAssertEqual(cup.remainingRolls, 0)

        let previousValues = cup.values

        // When
        cup.roll()
        cup.roll()
        cup.roll()

        // Then
        XCTAssertEqual(previousValues, cup.values)
        XCTAssertEqual(cup.remainingRolls, 0)
    }

    func test_reset() {
        // Given
        var cup = DiceCup()

        // Then
        XCTAssertEqual(cup.remainingRolls, 3)
        XCTAssertNil(cup.values)
        XCTAssertNil(cup.die1.value)
        XCTAssertNil(cup.die2.value)
        XCTAssertNil(cup.die3.value)
        XCTAssertNil(cup.die4.value)
        XCTAssertNil(cup.die5.value)

        // When
        cup.roll()

        // Then
        XCTAssertEqual(cup.remainingRolls, 2)
        XCTAssertNotNil(cup.values)
        XCTAssertNotNil(cup.die1.value)
        XCTAssertNotNil(cup.die2.value)
        XCTAssertNotNil(cup.die3.value)
        XCTAssertNotNil(cup.die4.value)
        XCTAssertNotNil(cup.die5.value)

        // When
        cup.roll()

        // Then
        XCTAssertEqual(cup.remainingRolls, 1)
        XCTAssertNotNil(cup.values)
        XCTAssertNotNil(cup.die1.value)
        XCTAssertNotNil(cup.die2.value)
        XCTAssertNotNil(cup.die3.value)
        XCTAssertNotNil(cup.die4.value)
        XCTAssertNotNil(cup.die5.value)

        // When
        cup.roll()

        // Then
        XCTAssertEqual(cup.remainingRolls, 0)
        XCTAssertNotNil(cup.values)
        XCTAssertNotNil(cup.die1.value)
        XCTAssertNotNil(cup.die2.value)
        XCTAssertNotNil(cup.die3.value)
        XCTAssertNotNil(cup.die4.value)
        XCTAssertNotNil(cup.die5.value)

        // When
        cup.reset()

        // Then
        XCTAssertEqual(cup.remainingRolls, 3)
        XCTAssertNil(cup.values)
        XCTAssertNil(cup.die1.value)
        XCTAssertNil(cup.die2.value)
        XCTAssertNil(cup.die3.value)
        XCTAssertNil(cup.die4.value)
        XCTAssertNil(cup.die5.value)
    }

    func test_hold() {
        // Given
        var cup = DiceCup()

        cup.roll(DiceValues(.six, .one, .three, .six, .six))

        // Then
        XCTAssertEqual(cup.die1.value, .six)
        XCTAssertEqual(cup.die4.value, .six)
        XCTAssertEqual(cup.die5.value, .six)
        XCTAssertEqual(cup.remainingRolls, 2)

        // When
        cup.hold(.one)
        cup.hold(.four)
        cup.hold(.five)
        cup.roll()

        // Then
        XCTAssertEqual(cup.die1.value, .six)
        XCTAssertEqual(cup.die4.value, .six)
        XCTAssertEqual(cup.die5.value, .six)
        XCTAssertEqual(cup.remainingRolls, 1)

        // When
        cup.roll()

        // Then
        XCTAssertEqual(cup.die1.value, .six)
        XCTAssertEqual(cup.die4.value, .six)
        XCTAssertEqual(cup.die5.value, .six)
        XCTAssertEqual(cup.remainingRolls, 0)

        // When
        cup.roll()

        // Then
        XCTAssertEqual(cup.die1.value, .six)
        XCTAssertEqual(cup.die4.value, .six)
        XCTAssertEqual(cup.die5.value, .six)
        XCTAssertEqual(cup.remainingRolls, 0)
    }

    func test_roll_with_given_values() {
        // Given
        var cup = DiceCup()

        XCTAssertNil(cup.values)

        // When
        cup.roll(DiceValues(.one, .two, .three, .four, .five))

        // Then
        XCTAssertNotNil(cup.values)
        XCTAssertEqual(cup.values?.value1, .one)
        XCTAssertEqual(cup.values?.value2, .two)
        XCTAssertEqual(cup.values?.value3, .three)
        XCTAssertEqual(cup.values?.value4, .four)
        XCTAssertEqual(cup.values?.value5, .five)
    }

    func test_roll_with_given_score_ones() {
        // Given
        var cup = DiceCup()

        // When
        let values = cup.roll(.init(scoreType: .ones, value: 3))

        // Then
        XCTAssertEqual(values.toArray().filter({ $0 == 1 }).count, 3)
    }

    func test_roll_with_given_score_twos() {
        // Given
        var cup = DiceCup()

        // When
        let values = cup.roll(.init(scoreType: .twos, value: 6))

        // Then
        XCTAssertEqual(values.toArray().filter({ $0 == 2 }).count, 3)
    }

    func test_roll_with_given_score_threes() {
        // Given
        var cup = DiceCup()

        // When
        let values = cup.roll(.init(scoreType: .threes, value: 9))

        // Then
        XCTAssertEqual(values.toArray().filter({ $0 == 3 }).count, 3)
    }

    func test_roll_with_given_score_fours() {
        // Given
        var cup = DiceCup()

        // When
        let values = cup.roll(.init(scoreType: .fours, value: 12))

        // Then
        XCTAssertEqual(values.toArray().filter({ $0 == 4 }).count, 3)
    }

    func test_roll_with_given_score_fives() {
        // Given
        var cup = DiceCup()

        // When
        let values = cup.roll(.init(scoreType: .fives, value: 15))

        // Then
        XCTAssertEqual(values.toArray().filter({ $0 == 5 }).count, 3)
    }

    func test_roll_with_given_score_sixes() {
        // Given
        var cup = DiceCup()

        // When
        let values = cup.roll(.init(scoreType: .sixes, value: 18))

        // Then
        XCTAssertEqual(values.toArray().filter({ $0 == 6 }).count, 3)
    }

    func test_roll_with_given_score_threeOfAKind() {
        // Given
        var cup = DiceCup()

        for total in 5...30 {
            let score = ScoreBox(scoreType: .threeOfAKind, value: total)

            // When
            let values = cup.roll(score)

            // Then
            XCTAssertTrue(values.isThreeOfAKind)
            XCTAssertEqual(values.total, total)
        }
    }

    func test_roll_with_given_score_fourOfAKind() {
        // Given
        var cup = DiceCup()

        for total in 5...30 {
            let score = ScoreBox(scoreType: .fourOfAKind, value: total)

            // When
            let values = cup.roll(score)

            // Then
            XCTAssertTrue(values.isFourOfAKind)
            XCTAssertEqual(values.total, total)
        }
    }

    func test_roll_with_given_score_fullHouse() {
        // Given
        var cup = DiceCup()

        // When
        let dice = cup.roll(ScoreBox(scoreType: .fullHouse, value: 25))

        // Then
        XCTAssertTrue(dice.isFullHouse)
    }

    func test_roll_with_given_score_smallStraight() {
        // Given
        var cup = DiceCup()

        // When
        let dice = cup.roll(ScoreBox(scoreType: .smallStraight, value: 30))

        // Then
        XCTAssertTrue(dice.isSmallStraight)
    }

    func test_roll_with_given_score_largeStraight() {
        // Given
        var cup = DiceCup()

        // When
        let dice = cup.roll(ScoreBox(scoreType: .largeStraight, value: 40))

        // Then
        XCTAssertTrue(dice.isLargeStraight)
    }

    func test_roll_with_given_score_yahtzee() {
        // Given
        var cup = DiceCup()

        // When
        let dice = cup.roll(ScoreBox(scoreType: .yahtzee, value: 50))

        // Then
        XCTAssertTrue(dice.isYahtzee)
    }

    func test_roll_with_given_score_chance() {
        // Given
        var cup = DiceCup()

        for total in 5...30 {
            let score = ScoreBox(scoreType: .fourOfAKind, value: total)

            // When
            let values = cup.roll(score)

            // Then
            XCTAssertEqual(values.total, total)
        }
    }

    func test_roll_with_given_score_fullGame() {
        let bot = ConfigurableBot(skillLevel: .ok)
        var scorecard = Scorecard()
        var cup = DiceCup()

        while scorecard.remainingTurns > 0 {
            let score = bot.takeTurn(scorecard)
            let dice = cup.roll(score)
            scorecard.score(score)

            switch score.scoreType {
            case .ones:
                XCTAssertEqual(
                    score.value,
                    dice.toArray().filter({ $0 == 1 }).reduce(0, { $0 + $1 })
                )
            case .twos:
                XCTAssertEqual(
                    score.value,
                    dice.toArray().filter({ $0 == 2 }).reduce(0, { $0 + $1 })
                )
            case .threes:
                XCTAssertEqual(
                    score.value,
                    dice.toArray().filter({ $0 == 3 }).reduce(0, { $0 + $1 })
                )
            case .fours:
                XCTAssertEqual(
                    score.value,
                    dice.toArray().filter({ $0 == 4 }).reduce(0, { $0 + $1 })
                )
            case .fives:
                XCTAssertEqual(
                    score.value,
                    dice.toArray().filter({ $0 == 5 }).reduce(0, { $0 + $1 })
                )
            case .sixes:
                XCTAssertEqual(
                    score.value,
                    dice.toArray().filter({ $0 == 6 }).reduce(0, { $0 + $1 })
                )
            case .threeOfAKind:
                XCTAssertTrue(dice.isThreeOfAKind)
                XCTAssertEqual(score.value, dice.total)

            case .fourOfAKind:
                XCTAssertTrue(dice.isFourOfAKind)
                XCTAssertEqual(score.value, dice.total)

            case .fullHouse:
                if score.valueOrZero > 0 {
                    XCTAssertTrue(dice.isFullHouse)
                } else {
                    XCTAssertFalse(dice.isFullHouse)
                }

            case .smallStraight:
                if score.valueOrZero > 0 {
                    XCTAssertTrue(dice.isSmallStraight)
                } else {
                    XCTAssertFalse(dice.isSmallStraight)
                }

            case .largeStraight:
                if score.valueOrZero > 0 {
                    XCTAssertTrue(dice.isLargeStraight)
                } else {
                    XCTAssertFalse(dice.isLargeStraight)
                }

            case .yahtzee:
                if score.valueOrZero > 0 {
                    XCTAssertTrue(dice.isYahtzee)
                } else {
                    XCTAssertFalse(dice.isYahtzee)
                }

            case .chance:
                XCTAssertEqual(score.value, dice.total)
            }
        }
    }
}

extension DiceValues {
    var total: Int {
        value1.rawValue + value2.rawValue + value3.rawValue + value4.rawValue + value5.rawValue
    }

    func toArray() -> [Int] {
        [
            value1.rawValue,
            value2.rawValue,
            value3.rawValue,
            value4.rawValue,
            value5.rawValue
        ]
    }
}
