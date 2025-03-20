//
//  DieValue.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 3/20/25.
//

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
