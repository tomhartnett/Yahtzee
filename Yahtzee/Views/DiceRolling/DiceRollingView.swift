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
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                parent.game.diceAction = .toggleDieHold
                parent.game.diceCup.hold(slot)
            }
        }

        func rollingDidComplete(_ dice: DiceValues, tuple: ScoreTuple?) {
            if parent.game.isOpponentTurn {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    guard let self, let tuple else { return }
                    parent.game.opponentScore(tuple: tuple, values: dice)
                }
            } else {
                DispatchQueue.main.async { [unowned self] in
                    self.parent.game.playerScorecard.evaluate(dice)
                    self.parent.game.isRollInProgress = false
                }
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
        case .rollDice(let values, let tuple):
            uiViewController.rollDice(values, tuple: tuple)
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
