//
//  DieNode.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 11/15/24.
//

import SceneKit
import YahtzeeKit

class DieNode: SCNNode {
    var isHeld: Bool = false {
        didSet {
            let contents: UIColor = isHeld ? DieNode.heldColor : DieNode.notHeldColor
            geometry?.materials.forEach { $0.emission.contents = contents }
        }
    }

    let dieSlot: DieSlot

    init(dieSlot: DieSlot) {
        self.dieSlot = dieSlot
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reset() {
        isHeld = false
        isHidden = true
    }
}

extension DieNode {
    static let heldColor: UIColor = .red
    static let notHeldColor: UIColor = .black
}
