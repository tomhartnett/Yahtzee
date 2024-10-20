//
//  DiceRollingView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 10/20/24.
//

import SwiftUI

struct DiceRollingView: UIViewControllerRepresentable {
    @Binding var controlInput: ControlInput?

    class Coordinator {
        var parent: DiceRollingView

        init(parent: DiceRollingView) {
            self.parent = parent
        }

        func rollDice(_ viewController: GameViewController) {
            viewController.rollDice()
        }
    }

    func makeUIViewController(context: Context) -> GameViewController {
        GameViewController()
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {
        switch controlInput {
        case .reset:
            uiViewController.resetDice()
        case .roll:
            uiViewController.rollDice()
        case .none:
            break
        }

        DispatchQueue.main.async {
            controlInput = nil
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
}
