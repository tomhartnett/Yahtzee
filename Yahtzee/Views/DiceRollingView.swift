//
//  DiceRollingView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 10/20/24.
//

import SwiftUI
import YahtzeeKit

struct DiceRollingView: UIViewControllerRepresentable {
    @Binding var game: Game

    class Coordinator: GameViewControllerDelegate {
        var parent: DiceRollingView

        init(_ parent: DiceRollingView) {
            self.parent = parent
        }

        func didToggleDieHold(_ slot: YahtzeeKit.DieSlot, isHeld: Bool) {
            DispatchQueue.main.async {
                self.parent.game.diceAction = .toggleDieHold
                self.parent.game.diceCup.hold(slot)
            }
        }

        func rollingDidComplete() {
            let values = parent.game.diceCup.values
            DispatchQueue.main.async {
                self.parent.game.playerScorecard.evaluate(values)
            }
        }
    }

    func makeUIViewController(context: Context) -> GameViewController {
        let viewController = GameViewController()
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        switch game.diceAction {
        case .resetDice:
            uiViewController.resetDice()
        case .rollDice(let values):
            uiViewController.rollDice(values)
        case .toggleDieHold:
            break // handled by Coordinator above
        case .none:
            break
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
