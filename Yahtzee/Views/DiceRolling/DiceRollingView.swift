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

    class Coordinator: DiceViewControllerDelegate {
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
                self.parent.game.isRollInProgress = false
            }
        }
    }

    func makeUIViewController(context: Context) -> DiceViewController {
        let viewController = DiceViewController()
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: DiceViewController, context: Context) {
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
