//
//  YahtzeeKit+Extensions.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 7/29/24.
//

import YahtzeeKit

extension DieValue {
    var displayLabel: String {
        switch self {
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        }
    }
}
