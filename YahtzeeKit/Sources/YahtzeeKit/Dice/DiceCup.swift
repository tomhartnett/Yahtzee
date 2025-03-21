//
//  DiceCup.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 3/20/25.
//

public struct DiceCup {
    public var values: DiceValues? {
        guard let value1 = die1.value,
              let value2 = die2.value,
              let value3 = die3.value,
              let value4 = die4.value,
              let value5 = die5.value else {
            return nil
        }

        return DiceValues(
            value1,
            value2,
            value3,
            value4,
            value5
        )
    }

    public var die1 = Die()

    public var die2 = Die()

    public var die3 = Die()

    public var die4 = Die()

    public var die5 = Die()

    public var remainingRolls: Int = 3

    public init() {}

    public mutating func roll(_ useValues: DiceValues? = nil) {
        guard remainingRolls > 0 else { return }

        if let values = useValues {
            die1.value = values.value1
            die2.value = values.value2
            die3.value = values.value3
            die4.value = values.value4
            die5.value = values.value5
        } else {
            die1.roll()
            die2.roll()
            die3.roll()
            die4.roll()
            die5.roll()
        }

        remainingRolls -= 1
    }

    public mutating func roll(_ tuple: ScoreTuple) -> DiceValues {
        guard tuple.valueOrZero > 0 else {
            return rollZero(for: tuple.scoreType)
        }

        var dice = [
            Die(), // 1
            Die(), // 2
            Die(), // 3
            Die(), // 4
            Die(), // 5
        ]

        switch tuple.scoreType {
        case .ones:
            let numberOfDice = tuple.valueOrZero

            for index in 0..<numberOfDice {
                dice[index].value = .one
            }

            for index in dice.indices {
                if dice[index].value == nil {
                    dice[index].value = DieValue.random(where: { $0 != .one })
                }
            }

        case .twos:
            let numberOfDice = tuple.valueOrZero / 2

            for index in 0..<numberOfDice {
                dice[index].value = .two
            }

            for index in dice.indices {
                if dice[index].value == nil {
                    dice[index].value = DieValue.random(where: { $0 != .two })
                }
            }

        case .threes:
            let numberOfDice = tuple.valueOrZero / 3

            for index in 0..<numberOfDice {
                dice[index].value = .three
            }

            for index in dice.indices {
                if dice[index].value == nil {
                    dice[index].value = DieValue.random(where: { $0 != .three })
                }
            }

        case .fours:
            let numberOfDice = tuple.valueOrZero / 4

            for index in 0..<numberOfDice {
                dice[index].value = .four
            }

            for index in dice.indices {
                if dice[index].value == nil {
                    dice[index].value = DieValue.random(where: { $0 != .four })
                }
            }

        case .fives:
            let numberOfDice = tuple.valueOrZero / 5

            for index in 0..<numberOfDice {
                dice[index].value = .five
            }

            for index in dice.indices {
                if dice[index].value == nil {
                    dice[index].value = .random(where: { $0 != .five })
                }
            }

        case .sixes:
            let numberOfDice = tuple.valueOrZero / 6

            for index in 0..<numberOfDice {
                dice[index].value = .six
            }

            for index in dice.indices {
                if dice[index].value == nil {
                    dice[index].value = .random(where: { $0 != .six })
                }
            }

        case .threeOfAKind:
            let threeOfAKindValue = [6, 5, 4, 3, 2, 1].first(where: { $0 * 3 < (tuple.valueOrZero - 1) }) ?? 1
            let threeOfAKindSum = threeOfAKindValue * 3
            let difference = tuple.valueOrZero - threeOfAKindSum

            let differentValue1 = [6, 5, 4, 3, 2, 1].randomElement(where: {
                difference - $0 > 0 && difference - $0 <= 6
            })!
            let differentValue2 = difference - differentValue1

            dice[0].value = DieValue(rawValue: threeOfAKindValue)!
            dice[1].value = DieValue(rawValue: threeOfAKindValue)!
            dice[2].value = DieValue(rawValue: threeOfAKindValue)!
            dice[3].value = DieValue(rawValue: differentValue1)!
            dice[4].value = DieValue(rawValue: differentValue2)! // crashed because value2 was 7

        case .fourOfAKind:
            let fourOfAKindValue = [6, 5, 4, 3, 2, 1].first(where: { $0 * 4 < (tuple.valueOrZero - 1) }) ?? 1
            let fourOfAKindSum = fourOfAKindValue * 4
            let difference = tuple.valueOrZero - fourOfAKindSum

            let differentValue = [6, 5, 4, 3, 2, 1]
                .first(where: { difference - $0 == 0 }) ?? 1

            dice[0].value = DieValue(rawValue: fourOfAKindValue)!
            dice[1].value = DieValue(rawValue: fourOfAKindValue)!
            dice[2].value = DieValue(rawValue: fourOfAKindValue)!
            dice[3].value = DieValue(rawValue: fourOfAKindValue)!
            dice[4].value = DieValue(rawValue: differentValue)!

        case .fullHouse:
            let dieValues = [DieValue.one, .two, .three, .four, .five, .six]
            let dieValue1 = dieValues.randomElement()!
            let dieValue2 = dieValues.filter({ $0 != dieValue1 }).randomElement()!

            dice[0].value = dieValue1
            dice[1].value = dieValue1
            dice[2].value = dieValue2
            dice[3].value = dieValue2
            dice[4].value = dieValue2

        case .smallStraight:
            let whichStraight = Int.random(in: 0...2)
            if whichStraight == 0 {
                dice[0].value = DieValue.one
                dice[1].value = DieValue.two
                dice[2].value = DieValue.three
                dice[3].value = DieValue.four
            } else if whichStraight == 1 {
                dice[0].value = DieValue.two
                dice[1].value = DieValue.three
                dice[2].value = DieValue.four
                dice[3].value = DieValue.five
            } else {
                dice[0].value = DieValue.three
                dice[1].value = DieValue.four
                dice[2].value = DieValue.five
                dice[3].value = DieValue.six
            }

            dice[4].value = DieValue.allCases.randomElement()!

        case .largeStraight:
            let whichStraight = Int.random(in: 0...1)
            if whichStraight == 0 {
                dice[0].value = DieValue.one
                dice[1].value = DieValue.two
                dice[2].value = DieValue.three
                dice[3].value = DieValue.four
                dice[4].value = DieValue.five
            } else {
                dice[0].value = DieValue.two
                dice[1].value = DieValue.three
                dice[2].value = DieValue.four
                dice[3].value = DieValue.five
                dice[4].value = DieValue.six
            }

        case .yahtzee:
            let dieValue = DieValue.random()
            dice[0].value = dieValue
            dice[1].value = dieValue
            dice[2].value = dieValue
            dice[3].value = dieValue
            dice[4].value = dieValue

        case .chance:
            var values: DiceValues
            repeat {
                values = .random()
            } while values.total != tuple.valueOrZero

            dice[0].value = values.value1
            dice[1].value = values.value2
            dice[2].value = values.value3
            dice[3].value = values.value4
            dice[4].value = values.value5
        }

        dice.shuffle()

        let values = DiceValues(
            dice[0].value!,
            dice[1].value!,
            dice[2].value!,
            dice[3].value!,
            dice[4].value!
        )

        return values
    }

    public mutating func rollZero(for scoreType: ScoreType) -> DiceValues {
        assert(scoreType != .chance, "Should never be able to roll 0 for chance")

        switch scoreType {
        case .ones:
            let allowedValues: [Int] = [2, 3, 4, 5, 6]
            return DiceValues(
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!)
            )

        case .twos:
            let allowedValues: [Int] = [1, 3, 4, 5, 6]
            return DiceValues(
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!)
            )

        case .threes:
            let allowedValues: [Int] = [1, 2, 4, 5, 6]
            return DiceValues(
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!)
            )

        case .fours:
            let allowedValues: [Int] = [1, 2, 3, 5, 6]
            return DiceValues(
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!)
            )

        case .fives:
            let allowedValues: [Int] = [1, 2, 3, 4, 6]
            return DiceValues(
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!)
            )

        case .sixes:
            let allowedValues: [Int] = [1, 2, 3, 4, 5]
            return DiceValues(
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!),
                DieValue(integer: allowedValues.randomElement()!)
            )

        case .threeOfAKind:
            var diceValues: DiceValues
            repeat {
                diceValues = .random()
            } while diceValues.isThreeOfAKind

            return diceValues

        case .fourOfAKind:
            var diceValues: DiceValues
            repeat {
                diceValues = .random()
            } while diceValues.isThreeOfAKind

            return diceValues

        case .fullHouse:
            var diceValues: DiceValues
            repeat {
                diceValues = .random()
            } while diceValues.isThreeOfAKind

            return diceValues

        case .smallStraight:
            var diceValues: DiceValues
            repeat {
                diceValues = .random()
            } while diceValues.isSmallStraight

            return diceValues

        case .largeStraight:
            var diceValues: DiceValues
            repeat {
                diceValues = .random()
            } while diceValues.isLargeStraight

            return diceValues

        case .yahtzee:
            var diceValues: DiceValues
            repeat {
                diceValues = .random()
            } while diceValues.isYahtzee

            return diceValues

        case .chance:
            // Cannot roll 0 for chance. There is an `assert` above to catch it.
            // But, I don't like crashing, so return something.
            return DiceValues.random()
        }
    }

    public mutating func hold(_ slot: DieSlot) {
        switch slot {
        case .one:
            die1.hold()
        case .two:
            die2.hold()
        case .three:
            die3.hold()
        case .four:
            die4.hold()
        case .five:
            die5.hold()
        }
    }

    public mutating func reset() {
        remainingRolls = 3
        die1.value = nil
        die2.value = nil
        die3.value = nil
        die4.value = nil
        die5.value = nil

        die1.isHeld = false
        die2.isHeld = false
        die3.isHeld = false
        die4.isHeld = false
        die5.isHeld = false
    }
}
