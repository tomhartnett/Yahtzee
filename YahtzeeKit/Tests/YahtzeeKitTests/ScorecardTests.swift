//
//  ScorecardTests.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 8/2/24.
//

@testable import YahtzeeKit
import Testing

struct ScorecardTests {
    @Test func emptyScorecard() {
        // Given
        let scorecard = Scorecard()

        // Then
        #expect(scorecard.ones.value == nil)
        #expect(scorecard.twos.value == nil)
        #expect(scorecard.threes.value == nil)
        #expect(scorecard.fours.value == nil)
        #expect(scorecard.fives.value == nil)
        #expect(scorecard.sixes.value == nil)
        #expect(scorecard.threeOfAKind.value == nil)
        #expect(scorecard.fourOfAKind.value == nil)
        #expect(scorecard.fullHouse.value == nil)
        #expect(scorecard.smallStraight.value == nil)
        #expect(scorecard.largeStraight.value == nil)
        #expect(scorecard.yahtzee.value == nil)
        #expect(scorecard.chance.value == nil)
        #expect(scorecard.upperTotal == 0)
        #expect(scorecard.upperBonus == 0)
        #expect(scorecard.lowerTotal == 0)
        #expect(scorecard.totalScore == 0)
    }

    @Test func scoreOnes() {
        // Given
        var scorecard = Scorecard()

        #expect(!scorecard.ones.hasValue)
        #expect(scorecard.ones.value == nil)
        #expect(scorecard.upperTotal == 0)
        #expect(scorecard.upperBonus == 0)
        #expect(scorecard.lowerTotal == 0)
        #expect(scorecard.totalScore == 0)

        // When
        scorecard.score(DiceValues(.one, .one, .one, .four, .five),
                        scoreType: .ones)

        // Then
        #expect(scorecard.ones.hasValue)
        #expect(scorecard.ones.value == 3)
        #expect(scorecard.upperTotal == 3)
        #expect(scorecard.upperBonus == 0)
        #expect(scorecard.lowerTotal == 0)
        #expect(scorecard.totalScore == 3)
    }

    @Test func upperBonus() {
        // Given
        var scorecard = Scorecard()

        #expect(scorecard.upperBonus == 0)

        // When
        scorecard.score(DiceValues(.one, .one, .one, .four, .five),
                        scoreType: .ones)
        scorecard.score(DiceValues(.two, .two, .two, .four, .five),
                        scoreType: .twos)
        scorecard.score(DiceValues(.three, .three, .three, .four, .five),
                        scoreType: .threes)
        scorecard.score(DiceValues(.four, .four, .one, .four, .five),
                        scoreType: .fours)
        scorecard.score(DiceValues(.five, .five, .one, .four, .five),
                        scoreType: .fives)

        // Then
        #expect(scorecard.upperTotal == 45)
        #expect(scorecard.upperBonus == 0)

        scorecard.score(DiceValues(.six, .six, .six, .one, .one),
                        scoreType: .sixes)

        // Then
        #expect(scorecard.upperTotal == 63)
        #expect(scorecard.upperBonus == 35)
    }

    @Test func totals() {
        // Given
        var scorecard = Scorecard()

        #expect(scorecard.upperTotal == 0)
        #expect(scorecard.upperBonus == 0)
        #expect(scorecard.lowerTotal == 0)
        #expect(scorecard.totalScore == 0)

        // When
        scorecard.score(DiceValues(.one, .one, .one, .one, .five), scoreType: .ones)
        scorecard.score(DiceValues(.two, .two, .one, .one, .five), scoreType: .twos)
        scorecard.score(DiceValues(.five, .five, .five, .one, .five), scoreType: .fives)
        scorecard.score(DiceValues(.six, .six, .six, .one, .five), scoreType: .threeOfAKind)
        scorecard.score(DiceValues(.one, .one, .one, .five, .five), scoreType: .fullHouse)

        // Then
        #expect(scorecard.upperTotal == 28)
        #expect(scorecard.upperBonus == 0)
        #expect(scorecard.lowerTotal == 49)
        #expect(scorecard.totalScore == 77)
    }

    @Test func evaluateFourOfAKind() {
        // Given
        var scorecard = Scorecard()

        #expect(scorecard.ones.possibleValue == nil)
        #expect(scorecard.twos.possibleValue == nil)
        #expect(scorecard.threes.possibleValue == nil)
        #expect(scorecard.fours.possibleValue == nil)
        #expect(scorecard.fives.possibleValue == nil)
        #expect(scorecard.sixes.possibleValue == nil)
        #expect(scorecard.threeOfAKind.possibleValue == nil)
        #expect(scorecard.fourOfAKind.possibleValue == nil)
        #expect(scorecard.smallStraight.possibleValue == nil)
        #expect(scorecard.largeStraight.possibleValue == nil)
        #expect(scorecard.yahtzee.possibleValue == nil)
        #expect(scorecard.chance.possibleValue == nil)

        // When
        scorecard.evaluate(DiceValues(.six, .six, .six, .six, .five))

        // Then
        #expect(scorecard.ones.possibleValue == 0)
        #expect(scorecard.twos.possibleValue == 0)
        #expect(scorecard.threes.possibleValue == 0)
        #expect(scorecard.fours.possibleValue == 0)
        #expect(scorecard.fives.possibleValue == 5)
        #expect(scorecard.sixes.possibleValue == 24)
        #expect(scorecard.threeOfAKind.possibleValue == 29)
        #expect(scorecard.fourOfAKind.possibleValue == 29)
        #expect(scorecard.smallStraight.possibleValue == 0)
        #expect(scorecard.largeStraight.possibleValue == 0)
        #expect(scorecard.yahtzee.possibleValue == 0)
        #expect(scorecard.chance.possibleValue == 29)
    }

    @Test func evaluateLargeStraight() {
        // Given
        var scorecard = Scorecard()

        #expect(scorecard.ones.possibleValue == nil)
        #expect(scorecard.twos.possibleValue == nil)
        #expect(scorecard.threes.possibleValue == nil)
        #expect(scorecard.fours.possibleValue == nil)
        #expect(scorecard.fives.possibleValue == nil)
        #expect(scorecard.sixes.possibleValue == nil)
        #expect(scorecard.threeOfAKind.possibleValue == nil)
        #expect(scorecard.fourOfAKind.possibleValue == nil)
        #expect(scorecard.smallStraight.possibleValue == nil)
        #expect(scorecard.largeStraight.possibleValue == nil)
        #expect(scorecard.yahtzee.possibleValue == nil)
        #expect(scorecard.chance.possibleValue == nil)

        // When
        scorecard.evaluate(DiceValues(.one, .two, .three, .four, .five))

        // Then
        #expect(scorecard.ones.possibleValue == 1)
        #expect(scorecard.twos.possibleValue == 2)
        #expect(scorecard.threes.possibleValue == 3)
        #expect(scorecard.fours.possibleValue == 4)
        #expect(scorecard.fives.possibleValue == 5)
        #expect(scorecard.sixes.possibleValue == 0)
        #expect(scorecard.threeOfAKind.possibleValue == 0)
        #expect(scorecard.fourOfAKind.possibleValue == 0)
        #expect(scorecard.smallStraight.possibleValue == 30)
        #expect(scorecard.largeStraight.possibleValue == 40)
        #expect(scorecard.yahtzee.possibleValue == 0)
        #expect(scorecard.chance.possibleValue == 15)
    }

    @Test func clearPossibleScores() {
        // Given
        var scorecard = Scorecard()

        // When
        scorecard.evaluate(DiceValues(.six, .six, .six, .six, .five))

        // Then
        #expect(scorecard.ones.possibleValue == 0)
        #expect(scorecard.twos.possibleValue == 0)
        #expect(scorecard.threes.possibleValue == 0)
        #expect(scorecard.fours.possibleValue == 0)
        #expect(scorecard.fives.possibleValue == 5)
        #expect(scorecard.sixes.possibleValue == 24)
        #expect(scorecard.threeOfAKind.possibleValue == 29)
        #expect(scorecard.fourOfAKind.possibleValue == 29)
        #expect(scorecard.smallStraight.possibleValue == 0)
        #expect(scorecard.largeStraight.possibleValue == 0)
        #expect(scorecard.yahtzee.possibleValue == 0)
        #expect(scorecard.chance.possibleValue == 29)

        // When
        scorecard.clearPossibleScores()

        // Then
        #expect(scorecard.ones.possibleValue == nil)
        #expect(scorecard.twos.possibleValue == nil)
        #expect(scorecard.threes.possibleValue == nil)
        #expect(scorecard.fours.possibleValue == nil)
        #expect(scorecard.fives.possibleValue == nil)
        #expect(scorecard.sixes.possibleValue == nil)
        #expect(scorecard.threeOfAKind.possibleValue == nil)
        #expect(scorecard.fourOfAKind.possibleValue == nil)
        #expect(scorecard.smallStraight.possibleValue == nil)
        #expect(scorecard.largeStraight.possibleValue == nil)
        #expect(scorecard.yahtzee.possibleValue == nil)
        #expect(scorecard.chance.possibleValue == nil)
    }

    @Test func remainingTurns() {
        // Given
        var scorecard = Scorecard()

        #expect(scorecard.remainingTurns == 13)

        // When
        scorecard.score(.init(scoreType: .ones, value: 0))

        // Then
        #expect(scorecard.remainingTurns == 12)

        // When
        scorecard.score(.init(scoreType: .twos, value: 0))
        scorecard.score(.init(scoreType: .threes, value: 0))
        scorecard.score(.init(scoreType: .fours, value: 0))
        scorecard.score(.init(scoreType: .fives, value: 0))
        scorecard.score(.init(scoreType: .sixes, value: 0))

        // Then
        #expect(scorecard.remainingTurns == 7)

        // When
        scorecard.score(.init(scoreType: .threeOfAKind, value: 0))
        scorecard.score(.init(scoreType: .fourOfAKind, value: 0))
        scorecard.score(.init(scoreType: .fullHouse, value: 0))
        scorecard.score(.init(scoreType: .smallStraight, value: 0))
        scorecard.score(.init(scoreType: .largeStraight, value: 0))
        scorecard.score(.init(scoreType: .yahtzee, value: 0))

        // Then
        #expect(scorecard.remainingTurns == 1)

        // When
        scorecard.score(.init(scoreType: .chance, value: 0))

        // Then
        #expect(scorecard.remainingTurns == 0)
    }

    @Test func getAdditionalYahtzeeWithBonus() {
        // Given
        var scorecard = Scorecard()

        scorecard.score(.init(scoreType: .yahtzee, value: 50))

        #expect(scorecard.yahtzeeBonusCount == 0)
        #expect(scorecard.yahtzeeBonus == 0)

        // When
        scorecard.score(.init(.one, .one, .one, .one, .one), scoreType: .ones)

        // Then
        #expect(scorecard.yahtzeeBonusCount == 1)
        #expect(scorecard.yahtzeeBonus == 100)
    }

    @Test func getAdditionalYahtzeeWithoutBonus() {
        // Given
        var scorecard = Scorecard()

        scorecard.score(.init(scoreType: .yahtzee, value: 0))

        #expect(scorecard.yahtzeeBonusCount == 0)
        #expect(scorecard.yahtzeeBonus == 0)

        // When
        scorecard.score(.init(.one, .one, .one, .one, .one), scoreType: .ones)

        // Then
        #expect(scorecard.yahtzeeBonusCount == 0)
        #expect(scorecard.yahtzeeBonus == 0)
    }
}

struct ScoreBoxTests {
    @Test func initWithValue() {
        // Given
        let score = ScoreBox(scoreType: .fives, value: 25, possibleValue: nil)

        // Then
        #expect(score.hasValue)
        #expect(!score.hasPossibleValue)
        #expect(score.value == 25)
        #expect(score.possibleValue == nil)
        #expect(score.valueOrZero == 25)
        #expect(score.possibleValueOrZero == 0)
    }

    @Test func initWithPossibleValue() {
        // Given
        let score = ScoreBox(scoreType: .fives, value: nil, possibleValue: 25)

        // Then
        #expect(!score.hasValue)
        #expect(score.hasPossibleValue)
        #expect(score.value == nil)
        #expect(score.possibleValue == 25)
        #expect(score.valueOrZero == 0)
        #expect(score.possibleValueOrZero == 25)
    }

    @Test func initWithoutValues() {
        // Given
        let score = ScoreBox(scoreType: .ones)

        // Then
        #expect(!score.hasValue)
        #expect(!score.hasPossibleValue)
        #expect(score.value == nil)
        #expect(score.possibleValue == nil)
        #expect(score.valueOrZero == 0)
        #expect(score.possibleValueOrZero == 0)
    }

    @Test func setValue() {
        // Given
        var score = ScoreBox(scoreType: .chance)

        // Then
        #expect(!score.hasValue)
        #expect(!score.hasPossibleValue)
        #expect(score.value == nil)
        #expect(score.possibleValue == nil)
        #expect(score.valueOrZero == 0)
        #expect(score.possibleValueOrZero == 0)

        // When
        score.setValue(25)

        // Then
        #expect(score.hasValue)
        #expect(!score.hasPossibleValue)
        #expect(score.value == 25)
        #expect(score.possibleValue == nil)
        #expect(score.valueOrZero == 25)
        #expect(score.possibleValueOrZero == 0)
    }

    @Test func setPossibleValue() {
        // Given
        var score = ScoreBox(scoreType: .chance)

        // Then
        #expect(!score.hasValue)
        #expect(!score.hasPossibleValue)
        #expect(score.value == nil)
        #expect(score.possibleValue == nil)
        #expect(score.valueOrZero == 0)
        #expect(score.possibleValueOrZero == 0)

        // When
        score.setPossibleValue(25)

        // Then
        #expect(!score.hasValue)
        #expect(score.hasPossibleValue)
        #expect(score.value == nil)
        #expect(score.possibleValue == 25)
        #expect(score.valueOrZero == 0)
        #expect(score.possibleValueOrZero == 25)
    }

    @Test func clearPossibleValue() {
        // Given
        var score = ScoreBox(scoreType: .chance, value: nil, possibleValue: 25)

        // Then
        #expect(!score.hasValue)
        #expect(score.hasPossibleValue)
        #expect(score.value == nil)
        #expect(score.possibleValue == 25)
        #expect(score.valueOrZero == 0)
        #expect(score.possibleValueOrZero == 25)

        // When
        score.clearPossibleValue()

        // Then
        #expect(!score.hasValue)
        #expect(!score.hasPossibleValue)
        #expect(score.value == nil)
        #expect(score.possibleValue == nil)
        #expect(score.valueOrZero == 0)
        #expect(score.possibleValueOrZero == 0)
    }

    @Test func isEmpty() {
        // When, Then
        #expect(ScoreBox(scoreType: .ones).isEmpty == true)

        // When, Then
        #expect(ScoreBox(scoreType: .ones, value: 1).isEmpty == false)
    }
}
