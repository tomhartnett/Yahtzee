//
//  GameAPI.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/18/24.
//

import Foundation

enum DieSlot {
    case one
    case two
    case three
    case four
    case five
}

struct Game {
    var playerScoreCard = ScoreCard()
    var opponentScoreCard = ScoreCard()
}

enum ScoreType {
    case ones
    case twos
    case threes
    case fours
    case fives
    case sixes
    case upperBonus
    case threeOfAKind
    case fourOfAKind
    case fullHouse
    case smallStraight
    case largeStraight
    case yahtzee
    case chance
}

struct CategoryScore {
    let category: ScoreType
    var score: Int
}

struct ScoreCard {
    var onesScore: CategoryScore?
    var twosScore: CategoryScore?
    var threesScore: CategoryScore?
    var foursScore: CategoryScore?
    var fivesScore: CategoryScore?
    var sixesScore: CategoryScore?
    var bonusScore: CategoryScore?
    var threeOfAKindScore: CategoryScore?
    var fourOfAKindScore: CategoryScore?
    var fullHouseScore: CategoryScore?
    var smallStraightScore: CategoryScore?
    var largeStraightScore: CategoryScore?
    var yahtzeeScore: CategoryScore?
    var chanceScoore: CategoryScore?
}

enum DieValue: Int {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6

    static func random() -> DieValue {
        let random = Int.random(in: 1...6)
        return DieValue(rawValue: random) ?? .one
    }
}

struct Die {
    var value: DieValue
    var isHeld: Bool = false

    mutating func roll() {
        guard !isHeld else { return }

        value = DieValue.random()
    }

    mutating func hold() {
        isHeld.toggle()
    }
}

struct DiceCup {
    var dieOne: Die

    var dieTwo: Die

    var dieThree: Die

    var dieFour: Die

    var dieFive: Die

    var remainingRolls: Int = 3

    var currentValues: [DieValue] {
        [
            dieOne.value,
            dieTwo.value,
            dieThree.value,
            dieFour.value,
            dieFive.value
        ]
    }

    init(
        dieOne: Die = Die(value: DieValue.random()),
        dieTwo: Die = Die(value: DieValue.random()),
        dieThree: Die = Die(value: DieValue.random()),
        dieFour: Die = Die(value: DieValue.random()),
        dieFive: Die = Die(value: DieValue.random())
    ) {
        self.dieOne = dieOne
        self.dieTwo = dieTwo
        self.dieThree = dieThree
        self.dieFour = dieFour
        self.dieFive = dieFive
    }

    mutating func roll() {
        guard remainingRolls > 0 else { return }

        dieOne.roll()
        dieTwo.roll()
        dieThree.roll()
        dieFour.roll()
        dieFive.roll()

        remainingRolls -= 1
    }

    mutating func hold(_ slot: DieSlot) {
        switch slot {
        case .one:
            dieOne.hold()
        case .two:
            dieTwo.hold()
        case .three:
            dieThree.hold()
        case .four:
            dieFour.hold()
        case .five:
            dieFive.hold()
        }
    }

    func possibleScores() -> [CategoryScore] {
        var possibleScores = [CategoryScore]()

        let dice = currentValues

        var dictionary = [DieValue: Int]()
        dictionary[.one] = dice.filter({ $0 == .one }).count
        dictionary[.two] = dice.filter({ $0 == .two }).count
        dictionary[.three] = dice.filter({ $0 == .three }).count
        dictionary[.four] = dice.filter({ $0 == .four }).count
        dictionary[.five] = dice.filter({ $0 == .five }).count
        dictionary[.six] = dice.filter({ $0 == .six }).count

        if let onesCount = dictionary[.one], onesCount > 0 {
            possibleScores.append(CategoryScore(category: .ones, score: onesCount))
        }
        
        if let twosCount = dictionary[.two], twosCount > 0 {
            possibleScores.append(CategoryScore(category: .twos, score: twosCount * 2))
        }
        
        if let threesCount = dictionary[.three], threesCount > 0 {
            possibleScores.append(CategoryScore(category: .threes, score: threesCount * 3))
        }
        
        if let foursCount = dictionary[.four], foursCount > 0 {
            possibleScores.append(CategoryScore(category: .fours, score: foursCount * 4))
        }
        
        if let fivesCount = dictionary[.five], fivesCount > 0 {
            possibleScores.append(CategoryScore(category: .fives, score: fivesCount * 5))
        }

        if let sixesCount = dictionary[.six], sixesCount > 0 {
            possibleScores.append(CategoryScore(category: .sixes, score: sixesCount * 6))
        }

        let allDiceTotal = dice.reduce(0, { $0 + $1.rawValue })

        if dictionary.values.first(where: { $0 == 5 }) != nil {
            possibleScores.append(CategoryScore(category: .yahtzee, score: 50))
            possibleScores.append(CategoryScore(category: .fourOfAKind, score: allDiceTotal))
            possibleScores.append(CategoryScore(category: .threeOfAKind, score: allDiceTotal))
        } else if dictionary.filter({ $0.value == 4 }).first != nil {
            possibleScores.append(CategoryScore(category: .fourOfAKind, score: allDiceTotal))
            possibleScores.append(CategoryScore(category: .threeOfAKind, score: allDiceTotal))
        } else if dictionary.filter({ $0.value == 3 }).first != nil {
            possibleScores.append(CategoryScore(category: .threeOfAKind, score: allDiceTotal))
        }

        if dictionary.filter({ $0.value == 2 }).first != nil && dictionary.filter({ $0.value == 3 }).first != nil {
            possibleScores.append(CategoryScore(category: .fullHouse, score: 25))
        }

        let uniqueCount = dictionary.values.filter({ $0 == 1 }).count

        if uniqueCount == 5 {
            possibleScores.append(CategoryScore(category: .largeStraight, score: 40))
            possibleScores.append(CategoryScore(category: .smallStraight, score: 30))
        } else if uniqueCount >= 4 {
            possibleScores.append(CategoryScore(category: .smallStraight, score: 30))
        }

        return possibleScores
    }
}
