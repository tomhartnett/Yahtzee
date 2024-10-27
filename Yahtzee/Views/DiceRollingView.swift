//
//  DiceRollingView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 10/20/24.
//

import SwiftUI
import YahtzeeKit

struct DiceRollingView: UIViewControllerRepresentable {
    @Binding var diceCup: DiceCup

    @Binding var diceAction: DiceAction?

    class Coordinator: GameViewControllerDelegate {
        var parent: DiceRollingView

        init(_ parent: DiceRollingView) {
            self.parent = parent
        }

        func didToggleDieHold(_ slot: YahtzeeKit.DieSlot, isHeld: Bool) {
            DispatchQueue.main.async {
                self.parent.diceAction = .toggleDieHold
                self.parent.diceCup.hold(slot)
            }
        }
    }

    func makeUIViewController(context: Context) -> GameViewController {
        let viewController = GameViewController()
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        switch diceAction {
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
