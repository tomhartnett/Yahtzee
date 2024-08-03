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
        var scorer = DiceScorer(DiceValues(.one, .one, .three, .four, .five))

        // Then
        XCTAssertEqual(scorer.total(for: .one), 2)
        XCTAssertEqual(scorer.total(for: .two), 0)
        XCTAssertEqual(scorer.total(for: .three), 3)
        XCTAssertEqual(scorer.total(for: .four), 4)
        XCTAssertEqual(scorer.total(for: .five), 5)
        XCTAssertEqual(scorer.total(for: .six), 0)
        XCTAssertEqual(scorer.diceTotal, 14)

        // Given
        scorer = DiceScorer(DiceValues(.two, .three, .four, .five, .six))

        // Then
        XCTAssertEqual(scorer.total(for: .one), 0)
        XCTAssertEqual(scorer.total(for: .two), 2)
        XCTAssertEqual(scorer.total(for: .three), 3)
        XCTAssertEqual(scorer.total(for: .four), 4)
        XCTAssertEqual(scorer.total(for: .five), 5)
        XCTAssertEqual(scorer.total(for: .six), 6)
        XCTAssertEqual(scorer.diceTotal, 20)

        // Given
        scorer = DiceScorer(DiceValues(.four, .four, .four, .four, .four))

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
        let scorer = DiceScorer(DiceValues(.two, .four, .four, .three, .four))

        // Then
        XCTAssertEqual(scorer.hasThreeOfAKind, true)
        XCTAssertEqual(scorer.hasFourOfAKind, false)
    }

    func test_fourOfAKind() {
        // Given
        let scorer = DiceScorer(DiceValues(.four, .four, .four, .three, .four))

        // Then
        XCTAssertEqual(scorer.hasThreeOfAKind, true)
        XCTAssertEqual(scorer.hasFourOfAKind, true)
    }

    func test_fullHouse() {
        // Given
        let scorer = DiceScorer(DiceValues(.one, .one, .one, .two, .two))

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

    func test_smallStraigt() {
        // Given
        let scorer = DiceScorer(DiceValues(.one, .one, .two, .three, .four))

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

    func test_largeStraight() {
        // Given
        let scorer = DiceScorer(DiceValues(.one, .two, .three, .four, .five))

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
        var scorer = DiceScorer(DiceValues(.one, .one, .one, .one, .one))

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
        scorer = DiceScorer(DiceValues(.four, .four, .four, .four, .four))

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
        scorer = DiceScorer(DiceValues(.six, .six, .six, .six, .six))

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
}
