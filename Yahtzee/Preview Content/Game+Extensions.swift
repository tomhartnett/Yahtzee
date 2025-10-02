//
//  Game+Extensions.swift
//  Rollzee
//
//  Created by Tom Hartnett on 10/2/25.
//

import YahtzeeKit

extension Game {
    static var previewSample: Game {
        Game(botOpponent: ConfigurableBot(skillLevel: .ok))
    }
}
