//
//  BetterBot.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 8/5/24.
//

import Foundation

public class BetterBot: Bot {
    var diceCup: DiceCup

    public var name: String { "BetterBot" }

    public init() {
        diceCup = DiceCup()
    }

    public func takeTurn(_ scorecard: Scorecard, with values: DiceValues?) -> ScoreTuple {

        diceCup.reset()

        while diceCup.remainingRolls > 0 {
            if diceCup.remainingRolls == 3 {
                // Only use passed-in values on first roll, for testing.
                diceCup.roll(values)
            } else {
                diceCup.roll()
            }

            let scorer = DiceScorer(scorecard: scorecard, dice: diceCup.values)

            if let tuple = check(for: .yahtzee, scorecard, scorer) {
                return tuple
            }

            if let tuple = check(for: .largeStraight, scorecard, scorer) {
                return tuple
            }

            if diceCup.remainingRolls > 0 {
                if scorer.score(for: .fourOfAKind) > 16 {
                    if let duplicate = diceCup.getDieValueWithCount(4) {
                        diceCup.clearHolds()
                        diceCup.holdAny(duplicate)
                        continue
                    }
                }

                if scorer.hasSmallStraight {
                    if let duplicate = diceCup.getDieValueWithCount(2) {
                        diceCup.clearHolds()
                        diceCup.holdFirst(duplicate)
                        diceCup.holdIfNot(duplicate)
                        continue
                    }
                }

                if scorer.score(for: .threeOfAKind) > 12 {
                    if let duplicate = diceCup.getDieValueWithCount(3) {
                        diceCup.clearHolds()
                        diceCup.holdAny(duplicate)
                        continue
                    }
                }

                if scorer.count(for: .six) > 1 && scorecard.isScoreEmpty(.sixes) {
                    diceCup.clearHolds()
                    diceCup.holdAny(.six)
                    continue
                }

                if scorer.count(for: .five) > 1 && scorecard.isScoreEmpty(.fives) {
                    diceCup.clearHolds()
                    diceCup.holdAny(.five)
                    continue
                }

                if scorer.count(for: .four) > 1 && scorecard.isScoreEmpty(.fours) {
                    diceCup.clearHolds()
                    diceCup.holdAny(.four)
                    continue
                }

                if scorer.count(for: .three) > 1 && scorecard.isScoreEmpty(.threes) {
                    diceCup.clearHolds()
                    diceCup.holdAny(.three)
                    continue
                }

                if scorer.count(for: .two) > 1 && scorecard.isScoreEmpty(.twos) {
                    diceCup.clearHolds()
                    diceCup.holdAny(.two)
                    continue
                }

                if scorer.count(for: .one) > 1 && scorecard.isScoreEmpty(.ones) {
                    diceCup.clearHolds()
                    diceCup.holdAny(.one)
                    continue
                }
            }
        }

        return highestAvailableScore(scorecard, DiceScorer(scorecard: scorecard, dice: diceCup.values))
    }

    private func check(for scoreType: ScoreType, _ scorecard: Scorecard, _ scorer: DiceScorer) -> ScoreTuple? {
        let score = scorer.score(for: scoreType)
        if scorecard.isScoreEmpty(scoreType) && score > 0 {
            return ScoreTuple(type: scoreType, value: score)
        } else {
            return nil
        }
    }

    private func highestAvailableScore(_ scorecard: Scorecard, _ scorer: DiceScorer) -> ScoreTuple {
        var tuples = [ScoreTuple]()

        for scoreType in ScoreType.allCases {
            if scorecard.isScoreEmpty(scoreType) {
                tuples.append(ScoreTuple(type: scoreType, value: scorer.score(for: scoreType)))
            }
        }

        // TODO: remove force-unwrapping
        return tuples.sorted(by: { $0.valueOrZero > $1.valueOrZero }).first!
    }
}

extension DiceCup {
    func getDieValueWithCount(_ count: Int) -> DieValue? {
        let dieValues = [die1.value, die2.value, die3.value, die4.value, die5.value].compactMap({ $0 })
        for value in DieValue.allCases {
            if dieValues.count(where: { $0 == value }) == count {
                return value
            }
        }

        return nil
    }

    mutating func clearHolds() {
        die1.isHeld = false
        die2.isHeld = false
        die3.isHeld = false
        die4.isHeld = false
        die5.isHeld = false
    }

    mutating func holdFirst(_ dieValue: DieValue) {
        if die1.value == dieValue {
            hold(DieSlot.one)
        } else if die2.value == dieValue {
            hold(DieSlot.two)
        } else if die3.value == dieValue {
            hold(DieSlot.three)
        } else if die4.value == dieValue {
            hold(DieSlot.four)
        } else if die5.value == dieValue {
            hold(DieSlot.five)
        }
    }

    mutating func holdAny(_ dieValue: DieValue) {
        if die1.value == dieValue {
            hold(DieSlot.one)
        }

        if die2.value == dieValue {
            hold(DieSlot.two)
        }

        if die3.value == dieValue {
            hold(DieSlot.three)
        }

        if die4.value == dieValue {
            hold(DieSlot.four)
        }

        if die5.value == dieValue {
            hold(DieSlot.five)
        }
    }

    mutating func holdIfNot(_ dieValue: DieValue) {
        if die1.value != dieValue {
            die1.hold()
        }

        if die2.value != dieValue {
            die2.hold()
        }

        if die3.value != dieValue {
            die3.hold()
        }

        if die4.value != dieValue {
            die4.hold()
        }

        if die5.value != dieValue {
            die5.hold()
        }
    }
}

extension Scorecard {
    func isScoreEmpty(_ scoreType: ScoreType) -> Bool {
        switch scoreType {
        case .ones:
            return ones.isEmpty
        case .twos:
            return twos.isEmpty
        case .threes:
            return threes.isEmpty
        case .fours:
            return fours.isEmpty
        case .fives:
            return fives.isEmpty
        case .sixes:
            return sixes.isEmpty
        case .threeOfAKind:
            return threeOfAKind.isEmpty
        case .fourOfAKind:
            return fourOfAKind.isEmpty
        case .fullHouse:
            return fullHouse.isEmpty
        case .smallStraight:
            return smallStraight.isEmpty
        case .largeStraight:
            return largeStraight.isEmpty
        case .yahtzee:
            return yahtzee.isEmpty
        case .chance:
            return chance.isEmpty
        }
    }
}
