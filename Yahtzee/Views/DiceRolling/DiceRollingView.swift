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

        weak var viewController: DiceViewController?
        var shouldSkipNextDisplayUpdate = false

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

        func rollingDidComplete(_ dice: DiceValues, score: ScoreBox?) {
            if parent.game.isOpponentTurn {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    guard let score else { return }
                    self?.parent.game.opponentScore(score: score, values: dice)
                    self?.parent.game.isRollInProgress = false
                    self?.parent.game.diceAction = nil
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.parent.game.playerScorecard.evaluate(dice)
                    self?.parent.game.isRollInProgress = false
                    self?.shouldSkipNextDisplayUpdate = true
                    self?.parent.game.diceAction = nil

                    if dice.isYahtzee {
                        self?.viewController?.runDiceAnimation(.inlineBump)
                    }
                }
            }
        }
    }

    func makeUIViewController(context: Context) -> DiceViewController {
        let viewController = DiceViewController()
        viewController.delegate = context.coordinator
        context.coordinator.viewController = viewController
        viewController.loadViewIfNeeded()
        viewController.displayDice(game.diceCup)
        return viewController
    }

    func updateUIViewController(_ uiViewController: DiceViewController, context: Context) {
        uiViewController.loadViewIfNeeded()

        switch game.diceAction {
        case .resetDice:
            uiViewController.resetDice()
        case .rollDice(let values, let score):
            uiViewController.rollDice(values, score: score)
        case .toggleDieHold:
            uiViewController.displayDice(game.diceCup)
        case .none:
            guard !context.coordinator.shouldSkipNextDisplayUpdate else {
                context.coordinator.shouldSkipNextDisplayUpdate = false
                return
            }
            uiViewController.displayDice(game.diceCup)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
