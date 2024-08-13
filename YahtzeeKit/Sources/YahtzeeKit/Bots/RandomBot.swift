//
//  RandomBot.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 8/4/24.
//

public class RandomBot: Bot {
    var diceCup: DiceCup

    public init() {
        diceCup = DiceCup()
    }

    public func takeTurn(_ scorecard: Scorecard, with values: DiceValues?) -> ScoreTuple {
        diceCup.roll()

        let scoreType = getNextScoreType(scorecard)
        let scorer = DiceScorer(diceCup.values)
        let score = scorer.score(for: scoreType)

        return ScoreTuple(type: scoreType, value: score)
    }

    private func getNextScoreType(_ scorecard: Scorecard) -> ScoreType {
        let scorer = DiceScorer(diceCup.values)

        if scorecard.yahtzee.isEmpty && scorer.hasYahtzee {
            return .yahtzee
        } else if scorecard.largeStraight.isEmpty && scorer.hasLargeStraight {
            return .largeStraight
        } else if scorecard.smallStraight.isEmpty && scorer.hasSmallStraight {
            return .smallStraight
        } else if scorecard.fullHouse.isEmpty && scorer.hasFullHouse {
            return .fullHouse
        } else if scorecard.fourOfAKind.isEmpty && scorer.hasFourOfAKind {
            return .fourOfAKind
        } else if scorecard.threeOfAKind.isEmpty && scorer.hasThreeOfAKind {
            return .threeOfAKind
        } else if scorecard.sixes.isEmpty && scorer.total(for: .six) > 0 {
            return .sixes
        } else if scorecard.fives.isEmpty && scorer.total(for: .five) > 0 {
            return .fives
        } else if scorecard.fours.isEmpty && scorer.total(for: .four) > 0 {
            return .fours
        } else if scorecard.threes.isEmpty && scorer.total(for: .three) > 0 {
            return .threes
        } else if scorecard.twos.isEmpty && scorer.total(for: .two) > 0 {
            return .twos
        } else if scorecard.ones.isEmpty && scorer.total(for: .one) > 0 {
            return .ones
        } else if scorecard.chance.isEmpty {
            return .chance
        } else {
            return scorecard.randomEmpty()
        }
    }
}

extension Scorecard {
    func randomEmpty() -> ScoreType {
        let tuples: [ScoreTuple] = [
            ones,
            twos,
            threes,
            fours,
            fives,
            sixes,
            threeOfAKind,
            fourOfAKind,
            fullHouse,
            smallStraight,
            largeStraight,
            yahtzee,
            chance
        ]

        let available = tuples.filter({ $0.isEmpty })

        let random = Int.random(in: 0..<available.count)

        return available[random].type
    }
}
