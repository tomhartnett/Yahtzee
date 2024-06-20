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
        var cup = DiceCup()

        // Then
        XCTAssertEqual(cup.currentValues.isEmpty, true)
        XCTAssertEqual(cup.remainingRolls, 3)
        XCTAssertEqual(cup.total(for: .one), 0)
        XCTAssertEqual(cup.total(for: .two), 0)
        XCTAssertEqual(cup.total(for: .three), 0)
        XCTAssertEqual(cup.total(for: .four), 0)
        XCTAssertEqual(cup.total(for: .five), 0)
        XCTAssertEqual(cup.total(for: .six), 0)
        XCTAssertEqual(cup.diceTotal, 0)

        // When
        cup.roll()

        // Then
        XCTAssertEqual(cup.currentValues.isEmpty, false)
        XCTAssertEqual(cup.remainingRolls, 2)
        XCTAssertEqual(cup.diceTotal > 0, true)
    }

    func test_remainingRolls() {
        // Given
        var cup = DiceCup()

        // Then
        XCTAssertTrue(cup.currentValues.isEmpty)
        XCTAssertEqual(cup.remainingRolls, 3)

        // When
        cup.roll()

        // Then
        XCTAssertEqual(cup.remainingRolls, 2)

        // When
        cup.roll()

        // Then
        XCTAssertEqual(cup.remainingRolls, 1)

        // When
        cup.roll()

        // Then
        XCTAssertEqual(cup.remainingRolls, 0)

        let values = cup.currentValues

        // When
        cup.roll()

        // Then
        XCTAssertEqual(values, cup.currentValues)
    }

    func test_reset() {
        // Given
        var cup = DiceCup()

        // Then
        XCTAssertEqual(cup.remainingRolls, 3)
        XCTAssertNil(cup.die1.value)
        XCTAssertNil(cup.die2.value)
        XCTAssertNil(cup.die3.value)
        XCTAssertNil(cup.die4.value)
        XCTAssertNil(cup.die5.value)

        // When
        cup.roll()

        // Then
        XCTAssertEqual(cup.remainingRolls, 2)
        XCTAssertNotNil(cup.die1.value)
        XCTAssertNotNil(cup.die2.value)
        XCTAssertNotNil(cup.die3.value)
        XCTAssertNotNil(cup.die4.value)
        XCTAssertNotNil(cup.die5.value)

        // When
        cup.roll()

        // Then
        XCTAssertEqual(cup.remainingRolls, 1)
        XCTAssertNotNil(cup.die1.value)
        XCTAssertNotNil(cup.die2.value)
        XCTAssertNotNil(cup.die3.value)
        XCTAssertNotNil(cup.die4.value)
        XCTAssertNotNil(cup.die5.value)

        // When
        cup.roll()

        // Then
        XCTAssertEqual(cup.remainingRolls, 0)
        XCTAssertNotNil(cup.die1.value)
        XCTAssertNotNil(cup.die2.value)
        XCTAssertNotNil(cup.die3.value)
        XCTAssertNotNil(cup.die4.value)
        XCTAssertNotNil(cup.die5.value)

        // When
        cup.reset()

        // Then
        XCTAssertEqual(cup.remainingRolls, 3)
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

    func test_total_for() {
        // Given
        var cup = DiceCup()

        // When
        cup.roll(DiceValues(.one, .one, .three, .four, .five))

        // Then
        XCTAssertEqual(cup.total(for: .one), 2)
        XCTAssertEqual(cup.total(for: .two), 0)
        XCTAssertEqual(cup.total(for: .three), 3)
        XCTAssertEqual(cup.total(for: .four), 4)
        XCTAssertEqual(cup.total(for: .five), 5)
        XCTAssertEqual(cup.total(for: .six), 0)
        XCTAssertEqual(cup.diceTotal, 14)

        // When
        cup.roll(DiceValues(.two, .three, .four, .five, .six))

        // Then
        XCTAssertEqual(cup.total(for: .one), 0)
        XCTAssertEqual(cup.total(for: .two), 2)
        XCTAssertEqual(cup.total(for: .three), 3)
        XCTAssertEqual(cup.total(for: .four), 4)
        XCTAssertEqual(cup.total(for: .five), 5)
        XCTAssertEqual(cup.total(for: .six), 6)
        XCTAssertEqual(cup.diceTotal, 20)

        // When
        cup.roll(DiceValues(.four, .four, .four, .four, .four))

        // Then
        XCTAssertEqual(cup.total(for: .one), 0)
        XCTAssertEqual(cup.total(for: .two), 0)
        XCTAssertEqual(cup.total(for: .three), 0)
        XCTAssertEqual(cup.total(for: .four), 20)
        XCTAssertEqual(cup.total(for: .five), 0)
        XCTAssertEqual(cup.total(for: .six), 0)
        XCTAssertEqual(cup.diceTotal, 20)
    }

    func test_threeOfAKind() {
        // Given
        var cup = DiceCup()

        // When
        cup.roll(DiceValues(.two, .four, .four, .three, .four))

        // Then
        XCTAssertEqual(cup.hasThreeOfAKind, true)
        XCTAssertEqual(cup.hasFourOfAKind, false)
    }

    func test_fourOfAKind() {
        // Given
        var cup = DiceCup()

        // When
        cup.roll(DiceValues(.four, .four, .four, .three, .four))

        // Then
        XCTAssertEqual(cup.hasThreeOfAKind, true)
        XCTAssertEqual(cup.hasFourOfAKind, true)
    }

    func test_fullHouse() {
        // Given
        var cup = DiceCup()

        // When
        cup.roll(DiceValues(.one, .one, .one, .two, .two))

        // Then
        XCTAssertEqual(cup.total(for: .one), 3)
        XCTAssertEqual(cup.total(for: .two), 4)
        XCTAssertEqual(cup.total(for: .three), 0)
        XCTAssertEqual(cup.total(for: .four), 0)
        XCTAssertEqual(cup.total(for: .five), 0)
        XCTAssertEqual(cup.total(for: .six), 0)
        XCTAssertEqual(cup.hasThreeOfAKind, true)
        XCTAssertEqual(cup.hasFourOfAKind, false)
        XCTAssertEqual(cup.hasFullHouse, true)
        XCTAssertEqual(cup.hasSmallStraight, false)
        XCTAssertEqual(cup.hasLargeStraight, false)
        XCTAssertEqual(cup.hasYahtzee, false)
        XCTAssertEqual(cup.diceTotal, 7)
    }

    func test_smallStraigt() {
        // Given
        var cup = DiceCup()

        // When
        cup.roll(DiceValues(.one, .one, .two, .three, .four))

        // Then
        XCTAssertEqual(cup.total(for: .one), 2)
        XCTAssertEqual(cup.total(for: .two), 2)
        XCTAssertEqual(cup.total(for: .three), 3)
        XCTAssertEqual(cup.total(for: .four), 4)
        XCTAssertEqual(cup.total(for: .five), 0)
        XCTAssertEqual(cup.total(for: .six), 0)
        XCTAssertEqual(cup.hasThreeOfAKind, false)
        XCTAssertEqual(cup.hasFourOfAKind, false)
        XCTAssertEqual(cup.hasFullHouse, false)
        XCTAssertEqual(cup.hasSmallStraight, true)
        XCTAssertEqual(cup.hasLargeStraight, false)
        XCTAssertEqual(cup.hasYahtzee, false)
        XCTAssertEqual(cup.diceTotal, 11)
    }

    func test_largeStraight() {
        // Given
        var cup = DiceCup()

        // When
        cup.roll(DiceValues(.one, .two, .three, .four, .five))

        // Then
        XCTAssertEqual(cup.total(for: .one), 1)
        XCTAssertEqual(cup.total(for: .two), 2)
        XCTAssertEqual(cup.total(for: .three), 3)
        XCTAssertEqual(cup.total(for: .four), 4)
        XCTAssertEqual(cup.total(for: .five), 5)
        XCTAssertEqual(cup.total(for: .six), 0)
        XCTAssertEqual(cup.hasThreeOfAKind, false)
        XCTAssertEqual(cup.hasFourOfAKind, false)
        XCTAssertEqual(cup.hasFullHouse, false)
        XCTAssertEqual(cup.hasSmallStraight, true)
        XCTAssertEqual(cup.hasLargeStraight, true)
        XCTAssertEqual(cup.hasYahtzee, false)
        XCTAssertEqual(cup.diceTotal, 15)
    }

    func test_yahtzee() throws {
        // Given
        var cup = DiceCup()

        // When
        cup.roll(DiceValues(.one, .one, .one, .one, .one))

        // Then
        XCTAssertEqual(cup.total(for: .one), 5)
        XCTAssertEqual(cup.total(for: .two), 0)
        XCTAssertEqual(cup.total(for: .three), 0)
        XCTAssertEqual(cup.total(for: .four), 0)
        XCTAssertEqual(cup.total(for: .five), 0)
        XCTAssertEqual(cup.total(for: .six), 0)
        XCTAssertTrue(cup.hasThreeOfAKind)
        XCTAssertTrue(cup.hasFourOfAKind)
        XCTAssertFalse(cup.hasFullHouse)
        XCTAssertFalse(cup.hasSmallStraight)
        XCTAssertFalse(cup.hasLargeStraight)
        XCTAssertTrue(cup.hasYahtzee)
        XCTAssertEqual(cup.diceTotal, 5)
    }
}
