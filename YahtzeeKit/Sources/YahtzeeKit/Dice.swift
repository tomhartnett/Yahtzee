//
//  Dice.swift
//
//
//  Created by Tom Hartnett on 6/20/24.
//

import Foundation

public enum DieSlot {
    case one
    case two
    case three
    case four
    case five
}

public enum DieValue: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6

    public init(integer: Int) {
        self = .init(rawValue: integer) ?? .one
    }

    public static func random() -> DieValue {
        let random = Int.random(in: 1...6)
        return DieValue(integer: random)
    }
}

public struct Die {
    public var value: DieValue?
    public var isHeld: Bool = false

    public init(value: DieValue? = nil, isHeld: Bool = false) {
        self.value = value
        self.isHeld = isHeld
    }

    mutating func roll() {
        guard !isHeld else { return }

        value = DieValue.random()
    }

    mutating func hold() {
        guard value != nil else { return }

        isHeld.toggle()
    }
}

public struct DiceValues: Equatable {
    public let value1: DieValue
    public let value2: DieValue
    public let value3: DieValue
    public let value4: DieValue
    public let value5: DieValue

    public var isThreeOfAKind: Bool {
        // 1 1 1 3 4
        let set: Set<Int> = [
            value1.rawValue,
            value2.rawValue,
            value3.rawValue,
            value4.rawValue,
            value5.rawValue
        ]
        return set.count <= 3
    }

    public var isFourOfAKind: Bool {
        // 1 1 1 1 4
        let set: Set<Int> = [
            value1.rawValue,
            value2.rawValue,
            value3.rawValue,
            value4.rawValue,
            value5.rawValue
        ]
        return set.count <= 2
    }

    public var isFullHouse: Bool {
        // 1 1 1 4 4
        let set: Set<Int> = [
            value1.rawValue,
            value2.rawValue,
            value3.rawValue,
            value4.rawValue,
            value5.rawValue
        ]
        return set.count == 2
    }

    public var isSmallStraight: Bool {
        // 1 2 3 4 4
        let set: Set<Int> = [
            value1.rawValue,
            value2.rawValue,
            value3.rawValue,
            value4.rawValue,
            value5.rawValue
        ]
        return set.count >= 4
    }

    public var isLargeStraight: Bool {
        // 1 2 3 4 5
        let set: Set<Int> = [
            value1.rawValue,
            value2.rawValue,
            value3.rawValue,
            value4.rawValue,
            value5.rawValue
        ]
        return set.count == 5
    }

    public var isYahtzee: Bool {
        // 1 1 1 1 1
        [value1, value2, value3, value4, value5].allSatisfy({ $0 == value1 })
    }

    init(
        _ value1: DieValue,
        _ value2: DieValue,
        _ value3: DieValue,
        _ value4: DieValue,
        _ value5: DieValue
    ) {
        self.value1 = value1
        self.value2 = value2
        self.value3 = value3
        self.value4 = value4
        self.value5 = value5
    }

    init(
        _ value1: DieValue?,
        _ value2: DieValue?,
        _ value3: DieValue?,
        _ value4: DieValue?,
        _ value5: DieValue?
    ) {
        self.value1 = value1 ?? .one
        self.value2 = value2 ?? .one
        self.value3 = value3 ?? .one
        self.value4 = value4 ?? .one
        self.value5 = value5 ?? .one
    }
}

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

        var dice = [die1, die2, die3, die4, die5]

        switch tuple.scoreType {
        case .ones:
            let numberOfDice = tuple.valueOrZero
            repeat {
                let index = Int.random(in: 0...4)
                dice[index].value = .one
            } while dice.filter({ $0.value != nil }).count < numberOfDice

            for index in dice.indices {
                if dice[index].value == nil {
                    dice[index].value = [DieValue.two, .three, .four, .five, .six].randomElement()
                }
            }

        case .twos:
            let numberOfDice = tuple.valueOrZero / 2
            repeat {
                let index = Int.random(in: 0...4)
                dice[index].value = .two
            } while dice.filter({ $0.value != nil }).count < numberOfDice

            for index in dice.indices {
                if dice[index].value == nil {
                    dice[index].value = [DieValue.one, .three, .four, .five, .six].randomElement()
                }
            }

        case .threes:
            let numberOfDice = tuple.valueOrZero / 3
            repeat {
                let index = Int.random(in: 0...4)
                dice[index].value = .three
            } while dice.filter({ $0.value != nil }).count < numberOfDice

            for index in dice.indices {
                if dice[index].value == nil {
                    dice[index].value = [DieValue.one, .two, .four, .five, .six].randomElement()
                }
            }

        case .fours:
            let numberOfDice = tuple.valueOrZero / 4
            repeat {
                let index = Int.random(in: 0...4)
                dice[index].value = .four
            } while dice.filter({ $0.value != nil }).count < numberOfDice

            for index in dice.indices {
                if dice[index].value == nil {
                    dice[index].value = [DieValue.one, .two, .three, .five, .six].randomElement()
                }
            }

        case .fives:
            let numberOfDice = tuple.valueOrZero / 5
            repeat {
                let index = Int.random(in: 0...4)
                dice[index].value = .five
            } while dice.filter({ $0.value != nil }).count < numberOfDice

            for index in dice.indices {
                if dice[index].value == nil {
                    dice[index].value = [DieValue.one, .two, .three, .four, .six].randomElement()
                }
            }

        case .sixes:
            let numberOfDice = tuple.valueOrZero / 6
            repeat {
                let index = Int.random(in: 0...4)
                dice[index].value = .six
            } while dice.filter({ $0.value != nil }).count < numberOfDice

            for index in dice.indices {
                if dice[index].value == nil {
                    dice[index].value = [DieValue.one, .two, .three, .four, .five].randomElement()
                }
            }

        case .threeOfAKind:
            let threeOfAKindValue = [6, 5, 4, 3, 2, 1].first(where: { $0 * 3 < (tuple.valueOrZero - 2) }) ?? 1
            let threeOfAKindSum = threeOfAKindValue * 3
            let difference = tuple.valueOrZero - threeOfAKindSum

            let differentValue1 = [6, 5, 4, 3, 2, 1].randomElement(where: {
                $0 != threeOfAKindValue && difference - $0 > 0 && difference - $0 <= 6
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
                .filter({ $0 != fourOfAKindValue })
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
            let dieValue = DieValue.allCases.randomElement()!
            dice[0].value = dieValue
            dice[1].value = dieValue
            dice[2].value = dieValue
            dice[3].value = dieValue
            dice[4].value = dieValue

        case .chance:
            dice[0].value = .one
            dice[1].value = .one
            dice[2].value = .one
            dice[3].value = .one
            dice[4].value = .one

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
                diceValues = DiceValues(
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random()
                )
            } while diceValues.isThreeOfAKind

            return diceValues

        case .fourOfAKind:
            var diceValues: DiceValues
            repeat {
                diceValues = DiceValues(
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random()
                )
            } while diceValues.isThreeOfAKind

            return diceValues

        case .fullHouse:
            var diceValues: DiceValues
            repeat {
                diceValues = DiceValues(
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random()
                )
            } while diceValues.isThreeOfAKind

            return diceValues

        case .smallStraight:
            var diceValues: DiceValues
            repeat {
                diceValues = DiceValues(
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random()
                )
            } while diceValues.isThreeOfAKind

            return diceValues

        case .largeStraight:
            var diceValues: DiceValues
            repeat {
                diceValues = DiceValues(
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random()
                )
            } while diceValues.isThreeOfAKind

            return diceValues

        case .yahtzee:
            var diceValues: DiceValues
            repeat {
                diceValues = DiceValues(
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random()
                )
            } while diceValues.isThreeOfAKind

            return diceValues

        case .chance:
            var diceValues: DiceValues
            repeat {
                diceValues = DiceValues(
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random(),
                    DieValue.random()
                )
            } while diceValues.isThreeOfAKind

            return diceValues
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

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}

extension Array {
    func randomElement(where predicate: (Element) -> Bool) -> Element? {
        let filteredArray = filter(predicate)
        return filteredArray.isEmpty ? nil : filteredArray.randomElement()
    }
}
