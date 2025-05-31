//
//  DiceScorerTests.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 7/28/24.
//

@testable import YahtzeeKit
import XCTest

final class DiceScorerTests: XCTestCase {
    func test_total_for() {
        // Given
        var scorer = DiceScorer(scorecard: Scorecard(), dice: DiceValues(.one, .one, .three, .four, .five))

        // Then
        XCTAssertEqual(scorer.total(for: .one), 2)
        XCTAssertEqual(scorer.total(for: .two), 0)
        XCTAssertEqual(scorer.total(for: .three), 3)
        XCTAssertEqual(scorer.total(for: .four), 4)
        XCTAssertEqual(scorer.total(for: .five), 5)
        XCTAssertEqual(scorer.total(for: .six), 0)
        XCTAssertEqual(scorer.diceTotal, 14)

        // Given
        scorer = DiceScorer(scorecard: Scorecard(), dice: DiceValues(.two, .three, .four, .five, .six))

        // Then
        XCTAssertEqual(scorer.total(for: .one), 0)
        XCTAssertEqual(scorer.total(for: .two), 2)
        XCTAssertEqual(scorer.total(for: .three), 3)
        XCTAssertEqual(scorer.total(for: .four), 4)
        XCTAssertEqual(scorer.total(for: .five), 5)
        XCTAssertEqual(scorer.total(for: .six), 6)
        XCTAssertEqual(scorer.diceTotal, 20)

        // Given
        scorer = DiceScorer(scorecard: Scorecard(), dice: DiceValues(.four, .four, .four, .four, .four))

        // Then
        XCTAssertEqual(scorer.total(for: .one), 0)
        XCTAssertEqual(scorer.total(for: .two), 0)
        XCTAssertEqual(scorer.total(for: .three), 0)
        XCTAssertEqual(scorer.total(for: .four), 20)
        XCTAssertEqual(scorer.total(for: .five), 0)
        XCTAssertEqual(scorer.total(for: .six), 0)
        XCTAssertEqual(scorer.diceTotal, 20)
    }

    func test_threeOfAKind() {
        // Given
        let scorer = DiceScorer(scorecard: Scorecard(), dice: DiceValues(.two, .four, .four, .three, .four))

        // Then
        XCTAssertEqual(scorer.hasThreeOfAKind, true)
        XCTAssertEqual(scorer.hasFourOfAKind, false)
    }

    func test_fourOfAKind() {
        // Given
        let scorer = DiceScorer(scorecard: Scorecard(), dice: DiceValues(.four, .four, .four, .three, .four))

        // Then
        XCTAssertEqual(scorer.hasThreeOfAKind, true)
        XCTAssertEqual(scorer.hasFourOfAKind, true)
    }

    func test_fullHouse() {
        // Given
        let scorer = DiceScorer(scorecard: Scorecard(), dice: DiceValues(.one, .one, .one, .two, .two))

        // Then
        XCTAssertEqual(scorer.total(for: .one), 3)
        XCTAssertEqual(scorer.total(for: .two), 4)
        XCTAssertEqual(scorer.total(for: .three), 0)
        XCTAssertEqual(scorer.total(for: .four), 0)
        XCTAssertEqual(scorer.total(for: .five), 0)
        XCTAssertEqual(scorer.total(for: .six), 0)
        XCTAssertEqual(scorer.hasThreeOfAKind, true)
        XCTAssertEqual(scorer.hasFourOfAKind, false)
        XCTAssertEqual(scorer.hasFullHouse, true)
        XCTAssertEqual(scorer.hasSmallStraight, false)
        XCTAssertEqual(scorer.hasLargeStraight, false)
        XCTAssertEqual(scorer.hasYahtzee, false)
        XCTAssertEqual(scorer.diceTotal, 7)
    }

    func test_smallStraight() {
        // Given
        let scorer = DiceScorer(scorecard: Scorecard(), dice: DiceValues(.one, .one, .two, .three, .four))

        // Then
        XCTAssertEqual(scorer.total(for: .one), 2)
        XCTAssertEqual(scorer.total(for: .two), 2)
        XCTAssertEqual(scorer.total(for: .three), 3)
        XCTAssertEqual(scorer.total(for: .four), 4)
        XCTAssertEqual(scorer.total(for: .five), 0)
        XCTAssertEqual(scorer.total(for: .six), 0)
        XCTAssertEqual(scorer.hasThreeOfAKind, false)
        XCTAssertEqual(scorer.hasFourOfAKind, false)
        XCTAssertEqual(scorer.hasFullHouse, false)
        XCTAssertEqual(scorer.hasSmallStraight, true)
        XCTAssertEqual(scorer.hasLargeStraight, false)
        XCTAssertEqual(scorer.hasYahtzee, false)
        XCTAssertEqual(scorer.diceTotal, 11)
    }

    func test_notSmallStraight() {
        // Given
        let scorer = DiceScorer(scorecard: Scorecard(), dice: DiceValues(.three, .three, .four, .two, .six))

        // Then
        XCTAssertFalse(scorer.hasSmallStraight)
    }

    func test_notLargeStraight() {
        // Given
        let scorer = DiceScorer(scorecard: Scorecard(), dice: DiceValues(.one, .three, .four, .five, .six))

        // Then
        XCTAssertFalse(scorer.hasLargeStraight)
    }

    func test_largeStraight() {
        // Given
        let scorer = DiceScorer(scorecard: Scorecard(), dice: DiceValues(.one, .two, .three, .four, .five))

        // Then
        XCTAssertEqual(scorer.total(for: .one), 1)
        XCTAssertEqual(scorer.total(for: .two), 2)
        XCTAssertEqual(scorer.total(for: .three), 3)
        XCTAssertEqual(scorer.total(for: .four), 4)
        XCTAssertEqual(scorer.total(for: .five), 5)
        XCTAssertEqual(scorer.total(for: .six), 0)
        XCTAssertEqual(scorer.hasThreeOfAKind, false)
        XCTAssertEqual(scorer.hasFourOfAKind, false)
        XCTAssertEqual(scorer.hasFullHouse, false)
        XCTAssertEqual(scorer.hasSmallStraight, true)
        XCTAssertEqual(scorer.hasLargeStraight, true)
        XCTAssertEqual(scorer.hasYahtzee, false)
        XCTAssertEqual(scorer.diceTotal, 15)
    }

    func test_yahtzee() throws {
        // Given
        var scorer = DiceScorer(scorecard: Scorecard(), dice: DiceValues(.one, .one, .one, .one, .one))

        // Then
        XCTAssertEqual(scorer.total(for: .one), 5)
        XCTAssertEqual(scorer.total(for: .two), 0)
        XCTAssertEqual(scorer.total(for: .three), 0)
        XCTAssertEqual(scorer.total(for: .four), 0)
        XCTAssertEqual(scorer.total(for: .five), 0)
        XCTAssertEqual(scorer.total(for: .six), 0)
        XCTAssertTrue(scorer.hasThreeOfAKind)
        XCTAssertTrue(scorer.hasFourOfAKind)
        XCTAssertFalse(scorer.hasFullHouse)
        XCTAssertFalse(scorer.hasSmallStraight)
        XCTAssertFalse(scorer.hasLargeStraight)
        XCTAssertTrue(scorer.hasYahtzee)
        XCTAssertEqual(scorer.diceTotal, 5)

        // When
        scorer = DiceScorer(scorecard: Scorecard(), dice: DiceValues(.four, .four, .four, .four, .four))

        // Then
        XCTAssertEqual(scorer.total(for: .one), 0)
        XCTAssertEqual(scorer.total(for: .two), 0)
        XCTAssertEqual(scorer.total(for: .three), 0)
        XCTAssertEqual(scorer.total(for: .four), 20)
        XCTAssertEqual(scorer.total(for: .five), 0)
        XCTAssertEqual(scorer.total(for: .six), 0)
        XCTAssertTrue(scorer.hasThreeOfAKind)
        XCTAssertTrue(scorer.hasFourOfAKind)
        XCTAssertFalse(scorer.hasFullHouse)
        XCTAssertFalse(scorer.hasSmallStraight)
        XCTAssertFalse(scorer.hasLargeStraight)
        XCTAssertTrue(scorer.hasYahtzee)
        XCTAssertEqual(scorer.diceTotal, 20)

        // When
        scorer = DiceScorer(scorecard: Scorecard(), dice: DiceValues(.six, .six, .six, .six, .six))

        // Then
        XCTAssertEqual(scorer.total(for: .one), 0)
        XCTAssertEqual(scorer.total(for: .two), 0)
        XCTAssertEqual(scorer.total(for: .three), 0)
        XCTAssertEqual(scorer.total(for: .four), 0)
        XCTAssertEqual(scorer.total(for: .five), 0)
        XCTAssertEqual(scorer.total(for: .six), 30)
        XCTAssertTrue(scorer.hasThreeOfAKind)
        XCTAssertTrue(scorer.hasFourOfAKind)
        XCTAssertFalse(scorer.hasFullHouse)
        XCTAssertFalse(scorer.hasSmallStraight)
        XCTAssertFalse(scorer.hasLargeStraight)
        XCTAssertTrue(scorer.hasYahtzee)
        XCTAssertEqual(scorer.diceTotal, 30)
    }

    // MARK: - Joker Rules

    // Joke rules determine how a second/third/etc Yahtzee may be scored.
    // The rules apply whether the player scored 50 or 0 in the Yahtzee box.

    func test_joker_rules_lower_section() {
        // When an additional Yahtzee is rolled,
        // If the corresponding upper section box is already filled in,
        // Then the player may score any open lower section box for full point value.

        // Given
        var scorecard = Scorecard()
        scorecard.score(.init(scoreType: .ones, value: 5))
        scorecard.score(.init(scoreType: .yahtzee, value: 0))

        let scorer = DiceScorer(scorecard: scorecard, dice: DiceValues(.one, .one, .one, .one, .one))

        // When
        let possibleScores = scorer.evaluate()

        // Then
        XCTAssertNil(possibleScores.first(where: { $0.scoreType == .ones }))
        XCTAssertEqual(possibleScores.first(where: { $0.scoreType == .fullHouse })?.possibleValue, 25)
        XCTAssertEqual(possibleScores.first(where: { $0.scoreType == .smallStraight })?.possibleValue, 30)
        XCTAssertEqual(possibleScores.first(where: { $0.scoreType == .largeStraight })?.possibleValue, 40)
    }

    func test_joker_rules_upper_section() {
        // When an additional Yahtzee is rolled,
        // If the corresponding upper section score type is not yet filled in,
        // Then the player must select that score type from upper section.

        // Given
        var scorecard = Scorecard()
        scorecard.score(.init(scoreType: .yahtzee, value: 0))

        let scorer = DiceScorer(scorecard: scorecard, dice: DiceValues(.one, .one, .one, .one, .one))

        // When
        let possibleScores = scorer.evaluate()

        // Then
        XCTAssertEqual(possibleScores.first?.scoreType, .ones)
        XCTAssertEqual(possibleScores.count, 1)
    }

    func test_joker_rules_upper_section_forced_zero() {
        // When an additional Yahtzee is rolled,
        // If the corresponding upper section score type is filled in,
        // And all lower section boxes are filled in,
        // Then the player must enter zero in some upper section box.

        // Given
        var scorecard = Scorecard()
        scorecard.score(.init(scoreType: .ones, value: 0))
        scorecard.score(.init(scoreType: .threeOfAKind, value: 0))
        scorecard.score(.init(scoreType: .fourOfAKind, value: 0))
        scorecard.score(.init(scoreType: .fullHouse, value: 0))
        scorecard.score(.init(scoreType: .smallStraight, value: 0))
        scorecard.score(.init(scoreType: .largeStraight, value: 0))
        scorecard.score(.init(scoreType: .yahtzee, value: 0))
        scorecard.score(.init(scoreType: .chance, value: 0))

        let scorer = DiceScorer(scorecard: scorecard, dice: DiceValues(.one, .one, .one, .one, .one))

        // When
        let possibleScores = scorer.evaluate()

        // Then
        XCTAssertEqual(possibleScores.first(where: { $0.scoreType == .twos })?.possibleValue, 0)
        XCTAssertEqual(possibleScores.first(where: { $0.scoreType == .threes })?.possibleValue, 0)
        XCTAssertEqual(possibleScores.first(where: { $0.scoreType == .fours })?.possibleValue, 0)
        XCTAssertEqual(possibleScores.first(where: { $0.scoreType == .fives })?.possibleValue, 0)
        XCTAssertEqual(possibleScores.first(where: { $0.scoreType == .sixes })?.possibleValue, 0)
        XCTAssertEqual(possibleScores.count, 5)
    }
}
