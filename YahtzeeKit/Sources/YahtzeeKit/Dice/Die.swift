//
//  Die.swift
//  YahtzeeKit
//
//  Created by Tom Hartnett on 3/20/25.
//

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
