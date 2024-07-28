//
//  DiceScene.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/25/24.
//

import SceneKit

class DiceScene: SCNScene {
    var cameraNode: SCNNode?
    var die1: SCNNode?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        die1 = rootNode.childNode(withName: "die1", recursively: true)
        die1?.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 2 * CGFloat.pi, y: 0, z: 0, duration: 1)))
    }

    override init() {
        super.init()
    }
}
