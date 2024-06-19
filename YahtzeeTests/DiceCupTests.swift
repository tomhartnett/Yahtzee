//
//  DiceCupTests.swift
//  YahtzeeTests
//
//  Created by Tom Hartnett on 6/18/24.
//

@testable import Yahtzee
import XCTest

final class DiceCupTests: XCTestCase {
    func test_remainingRolls() {
        // Given
        var cup = DiceCup()

        // Then
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

    func test_yahtzee_ones() throws {
        // Given
        let cup = DiceCup(
            dieOne: Die(value: .one),
            dieTwo: Die(value: .one),
            dieThree: Die(value: .one),
            dieFour: Die(value: .one),
            dieFive: Die(value: .one)
        )

        // When
        let scores = cup.possibleScores()

        // Then
        XCTAssertEqual(scores.count, 4)

        let onesScore = try XCTUnwrap(scores.first(where: { $0.category == .ones }))
        XCTAssertEqual(onesScore.score, 5)

        let threeOfAKindScore = try XCTUnwrap(scores.first(where: { $0.category == .threeOfAKind }))
        XCTAssertEqual(threeOfAKindScore.score, 5)

        let fourOfAKindScore = try XCTUnwrap(scores.first(where: { $0.category == .fourOfAKind }))
        XCTAssertEqual(fourOfAKindScore.score, 5)

        let yahtzeeScore = try XCTUnwrap(scores.first(where: { $0.category == .yahtzee }))
        XCTAssertEqual(yahtzeeScore.score, 50)
    }

    func test_fullHouse() {
        // Given
        let cup = DiceCup(
            dieOne: Die(value: .one),
            dieTwo: Die(value: .one),
            dieThree: Die(value: .one),
            dieFour: Die(value: .two),
            dieFive: Die(value: .two)
        )

        // When
        let scores = cup.possibleScores()

        // Then
        XCTAssertEqual(scores.count, 4)

        let onesScore = scores.first(where: { $0.category == .ones })
        XCTAssertEqual(onesScore?.score, 3)

        let twosScore = scores.first(where: { $0.category == .twos })
        XCTAssertEqual(twosScore?.score, 4)

        let threeOfAKindScore = scores.first(where: { $0.category == .threeOfAKind })
        XCTAssertEqual(threeOfAKindScore?.score, 7)

        let fullHouseScore = scores.first(where: { $0.category == .fullHouse })
        XCTAssertEqual(fullHouseScore?.score, 25)
    }
}
