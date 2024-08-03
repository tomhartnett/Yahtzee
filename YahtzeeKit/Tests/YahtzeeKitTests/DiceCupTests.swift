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

    func test_values() {
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
}
