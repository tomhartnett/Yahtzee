//
//  DiceValuesTests.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 5/29/25.
//

import Testing
@testable import YahtzeeKit

struct DiceValuesTests {
    @Test("Is a three-of-a-kind", arguments: [
        DiceValues(1, 1, 1, 3, 4),
        DiceValues(6, 2, 6, 2, 6),
        DiceValues(4, 4, 4, 4, 1), // four-of-a-kind
        DiceValues(1, 1, 1, 1, 1)  // yahtzee
    ])
    func isThreeOfAKind_isTrue(dice: DiceValues) {
        #expect(dice.isThreeOfAKind)
    }

    @Test("Is not a three-of-a-kind", arguments: [
        DiceValues(6, 2, 6, 2, 5),
        DiceValues(1, 1, 3, 4, 4)
    ])
    func isThreeOfAKind_isFalse(dice: DiceValues) {
        #expect(!dice.isThreeOfAKind)
    }

    @Test("Is a four-of-a-kind", arguments: [
        DiceValues(1, 1, 1, 1, 2),
        DiceValues(1, 1, 1, 1, 1),
        DiceValues(4, 4, 3, 4, 4),
        DiceValues(3, 3, 3, 3, 3)
    ])
    func isFourOfAKind_isTrue(dice: DiceValues) {
        #expect(dice.isThreeOfAKind)
        #expect(dice.isFourOfAKind)
    }

    @Test("Is not a four-of-a-kind", arguments: [
        DiceValues(1, 1, 1, 2, 3),
        DiceValues(1, 1, 1, 4, 4),
        DiceValues(3, 1, 4, 2, 5)
    ])
    func isFourOfAKind_isFalse(dice: DiceValues) {
        #expect(!dice.isFourOfAKind)
    }

    @Test("Is a full house", arguments: [
        DiceValues(3, 3, 3, 4, 4),
        DiceValues(2, 3, 2, 3, 2),
        DiceValues(6, 4, 6, 4, 4)
    ])
    func isFullHouse_isTrue(dice: DiceValues) {
        #expect(dice.isThreeOfAKind)
        #expect(dice.isFullHouse)
    }

    @Test("Is not a full house", arguments: [
        DiceValues(4, 4, 4, 4, 4),
        DiceValues(1, 1, 1, 2, 3),
        DiceValues(1, 2, 3, 4, 5),
    ])
    func isFullHouse_isFalse(dice: DiceValues) {
        #expect(!dice.isFullHouse)
    }

    @Test("Is a small straight", arguments: [
        DiceValues(1, 2, 3, 4, 4),
        DiceValues(4, 3, 2, 6, 1),
        DiceValues(3, 4, 5, 6, 1),
        DiceValues(1, 2, 3, 4, 5), // large straight
        DiceValues(5, 3, 1, 4, 2)  // large straight
    ])
    func isSmallStraight_isTrue(dice: DiceValues) {
        #expect(dice.isSmallStraight)
    }

    @Test("Is not a small straight", arguments: [
        DiceValues(3, 3, 4, 2, 6),
        DiceValues(2, 3, 3, 4, 6),
        DiceValues(5, 6, 2, 4, 1)
    ])
    func isSmallStraight_isFalse(dice: DiceValues) {
        #expect(!dice.isSmallStraight)
    }

    @Test("Is a large straight", arguments: [
        DiceValues(1, 2, 3, 4, 5),
        DiceValues(2, 3, 4, 5, 6),
        DiceValues(3, 1, 5, 4, 2)
    ])
    func isLargeStraight_isTrue(dice: DiceValues) {
        #expect(dice.isSmallStraight)
        #expect(dice.isLargeStraight)
    }

    @Test("Is not a large straight", arguments: [
        DiceValues(3, 3, 4, 2, 6),
        DiceValues(2, 3, 3, 4, 6),
        DiceValues(5, 6, 2, 4, 1),
        DiceValues(6, 6, 6, 6, 6),
        DiceValues(1, 2, 3, 4, 4),
        DiceValues(4, 3, 2, 6, 1),
        DiceValues(3, 4, 5, 6, 1)
    ])
    func isLargeStraight_isFalse(dice: DiceValues) {
        #expect(!dice.isLargeStraight)
    }

    @Test("Is a yahtzee", arguments: [
        DiceValues(1, 1, 1, 1, 1),
        DiceValues(2, 2, 2, 2, 2),
        DiceValues(3, 3, 3, 3, 3),
        DiceValues(4, 4, 4, 4, 4),
        DiceValues(5, 5, 5, 5, 5),
        DiceValues(6, 6, 6, 6, 6),
    ])
    func isYahtzee_isTrue(dice: DiceValues) {
        #expect(dice.isThreeOfAKind)
        #expect(dice.isFourOfAKind)
        #expect(dice.isYahtzee)
    }

    @Test("Is not a yahtzee", arguments: [
        DiceValues(1, 1, 2, 1, 1),
        DiceValues(2, 2, 1, 2, 2),
        DiceValues(3, 3, 2, 3, 3),
        DiceValues(4, 4, 2, 4, 4),
        DiceValues(5, 5, 5, 5, 2),
        DiceValues(2, 6, 6, 6, 6),
    ])
    func isYahtzee_isFalse(dice: DiceValues) {
        #expect(!dice.isYahtzee)
    }

    @Test("Total for ones equals the expected amount", arguments: zip([
        DiceValues(2, 2, 3, 4, 4),
        DiceValues(1, 2, 3, 4, 5),
        DiceValues(1, 1, 3, 3, 3),
        DiceValues(1, 1, 1, 4, 5),
        DiceValues(1, 1, 1, 1, 2),
        DiceValues(1, 1, 1, 1, 1)
    ], [
        0, 1, 2, 3, 4, 5
    ]))
    func total_ones(dice: DiceValues, total: Int) {
        #expect(dice.total(for: .one) == total)
    }

    @Test("Total for twos equals the expected amount", arguments: zip([
        DiceValues(3, 4, 5, 1, 1),
        DiceValues(2, 4, 5, 1, 1),
        DiceValues(2, 2, 5, 1, 1),
        DiceValues(2, 2, 2, 1, 1),
        DiceValues(2, 2, 2, 2, 1),
        DiceValues(2, 2, 2, 2, 2)
    ], [
        0, 2, 4, 6, 8, 10
    ]))
    func total_twos(dice: DiceValues, total: Int) {
        #expect(dice.total(for: .two) == total)
    }

    @Test("Total for threes equals the expected amount", arguments: zip([
        DiceValues(2, 4, 5, 1, 1),
        DiceValues(3, 4, 5, 1, 1),
        DiceValues(3, 3, 5, 1, 1),
        DiceValues(3, 3, 3, 1, 1),
        DiceValues(3, 3, 3, 3, 1),
        DiceValues(3, 3, 3, 3, 3)
    ], [
        0, 3, 6, 9, 12, 15
    ]))
    func total_threes(dice: DiceValues, total: Int) {
        #expect(dice.total(for: .three) == total)
    }

    @Test("Total for fours equals the expected amount", arguments: zip([
        DiceValues(3, 2, 5, 1, 1),
        DiceValues(4, 2, 5, 1, 1),
        DiceValues(4, 4, 5, 1, 1),
        DiceValues(4, 4, 4, 1, 1),
        DiceValues(4, 4, 4, 4, 1),
        DiceValues(4, 4, 4, 4, 4)
    ], [
        0, 4, 8, 12, 16, 20
    ]))
    func total_fours(dice: DiceValues, total: Int) {
        #expect(dice.total(for: .four) == total)
    }

    @Test("Total for fives equals the expected amount", arguments: zip([
        DiceValues(3, 2, 2, 1, 1),
        DiceValues(5, 2, 2, 1, 1),
        DiceValues(5, 5, 2, 1, 1),
        DiceValues(5, 5, 5, 1, 1),
        DiceValues(5, 5, 5, 5, 1),
        DiceValues(5, 5, 5, 5, 5)
    ], [
        0, 5, 10, 15, 20, 25
    ]))
    func total_fives(dice: DiceValues, total: Int) {
        #expect(dice.total(for: .five) == total)
    }

    @Test("Total for sixes equals the expected amount", arguments: zip([
        DiceValues(3, 2, 2, 1, 1),
        DiceValues(6, 2, 2, 1, 1),
        DiceValues(6, 6, 2, 1, 1),
        DiceValues(6, 6, 6, 1, 1),
        DiceValues(6, 6, 6, 6, 1),
        DiceValues(6, 6, 6, 6, 6)
    ], [
        0, 6, 12, 18, 24, 30
    ]))
    func total_sixes(dice: DiceValues, total: Int) {
        #expect(dice.total(for: .six) == total)
    }

    @Test("Total for all dice equals the expected amount", arguments: zip([
        DiceValues(1, 5, 6, 5, 6),
        DiceValues(4, 4, 5, 5, 4),
        DiceValues(3, 3, 2, 2, 6),
        DiceValues(3, 4, 1, 1, 6),
        DiceValues(1, 1, 2, 3, 2),
        DiceValues(3, 6, 6, 3, 4)
    ], [
        23, 22, 16, 15, 9, 22
    ]))
    func total(dice: DiceValues, total: Int) {
        #expect(dice.total == total)
    }
}

extension DiceValues {
    init(
        _ value1: Int,
        _ value2: Int,
        _ value3: Int,
        _ value4: Int,
        _ value5: Int
    ) {
        self.init(
            .init(rawValue: value1),
            .init(rawValue: value2),
            .init(rawValue: value3),
            .init(rawValue: value4),
            .init(rawValue: value5)
        )
    }
}

// This silences `Capture of non-sendable type in @Sendable closure`.
// Probably not a "real" solution long-term.
extension DiceValues: @unchecked Sendable {}
