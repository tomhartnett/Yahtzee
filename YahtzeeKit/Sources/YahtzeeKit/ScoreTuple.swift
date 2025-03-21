//
//  ScoreTuple.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 3/20/25.
//

import Foundation

public struct ScoreTuple {
    public let scoreType: ScoreType
    public var value: Int?
    public var possibleValue: Int?

    public var hasValue: Bool {
        value != nil
    }

    public var isEmpty: Bool {
        !hasValue
    }

    public var hasPossibleValue: Bool {
        possibleValue != nil
    }

    public var valueOrZero: Int {
        return value ?? 0
    }

    public var possibleValueOrZero: Int {
        return possibleValue ?? 0
    }

    public var isAvailableForScoring: Bool {
        !hasValue && hasPossibleValue
    }

    public init(
        scoreType: ScoreType,
        value: Int? = nil,
        possibleValue: Int? = nil
    ) {
        self.scoreType = scoreType
        self.value = value
        self.possibleValue = possibleValue
    }

    public mutating func setValue(_ value: Int) {
        self.value = value
    }

    public mutating func setPossibleValue(_ possibleValue: Int) {
        self.possibleValue = possibleValue
    }

    public mutating func clearPossibleValue() {
        possibleValue = nil
    }
}
