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
        var cup = DiceCup()
        var scorer = DiceScorer()

        // When
        cup.roll(DiceValues(.one, .one, .three, .four, .five))
        scorer.score(cup.values)

        // Then
        XCTAssertEqual(scorer.total(for: .one), 2)
        XCTAssertEqual(scorer.total(for: .two), 0)
        XCTAssertEqual(scorer.total(for: .three), 3)
        XCTAssertEqual(scorer.total(for: .four), 4)
        XCTAssertEqual(scorer.total(for: .five), 5)
        XCTAssertEqual(scorer.total(for: .six), 0)
        XCTAssertEqual(scorer.diceTotal, 14)

        // When
        cup.roll(DiceValues(.two, .three, .four, .five, .six))
        scorer.score(cup.values)

        // Then
        XCTAssertEqual(scorer.total(for: .one), 0)
        XCTAssertEqual(scorer.total(for: .two), 2)
        XCTAssertEqual(scorer.total(for: .three), 3)
        XCTAssertEqual(scorer.total(for: .four), 4)
        XCTAssertEqual(scorer.total(for: .five), 5)
        XCTAssertEqual(scorer.total(for: .six), 6)
        XCTAssertEqual(scorer.diceTotal, 20)

        // When
        cup.roll(DiceValues(.four, .four, .four, .four, .four))
        scorer.score(cup.values)

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
        var cup = DiceCup()
        var scorer = DiceScorer()

        // When
        cup.roll(DiceValues(.two, .four, .four, .three, .four))
        scorer.score(cup.values)

        // Then
        XCTAssertEqual(scorer.hasThreeOfAKind, true)
        XCTAssertEqual(scorer.hasFourOfAKind, false)
    }

    func test_fourOfAKind() {
        // Given
        var cup = DiceCup()
        var scorer = DiceScorer()

        // When
        cup.roll(DiceValues(.four, .four, .four, .three, .four))
        scorer.score(cup.values)

        // Then
        XCTAssertEqual(scorer.hasThreeOfAKind, true)
        XCTAssertEqual(scorer.hasFourOfAKind, true)
    }

    func test_fullHouse() {
        // Given
        var cup = DiceCup()
        var scorer = DiceScorer()

        // When
        cup.roll(DiceValues(.one, .one, .one, .two, .two))
        scorer.score(cup.values)

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
        var cup = DiceCup()
        var scorer = DiceScorer()

        // When
        cup.roll(DiceValues(.one, .one, .two, .three, .four))
        scorer.score(cup.values)

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
        var cup = DiceCup()
        var scorer = DiceScorer()

        // When
        cup.roll(DiceValues(.one, .two, .three, .four, .five))
        scorer.score(cup.values)

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
        var cup = DiceCup()
        var scorer = DiceScorer()

        // When
        cup.roll(DiceValues(.one, .one, .one, .one, .one))
        scorer.score(cup.values)

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
        cup.roll(DiceValues(.four, .four, .four, .four, .four))
        scorer.score(cup.values)

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
        cup.roll(DiceValues(.six, .six, .six, .six, .six))
        scorer.score(cup.values)

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
