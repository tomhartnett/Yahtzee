//
//  RollDiceScene.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/23/24.
//

import SceneKit

class RollDiceScene: SCNScene {
    var cameraNode: SCNNode?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init() {
        super.init()

        setupCamera()
        setupLights()
        setupDice()
    }

    func setupCamera() {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        rootNode.addChildNode(cameraNode)

        cameraNode.position = SCNVector3(0, 4, 0)
        cameraNode.eulerAngles = SCNVector3(-Float.pi / 2, 0, 0)

        self.cameraNode = cameraNode
    }

    func setupLights() {
//        let ambientLightNode = SCNNode()
//        let ambientLight = SCNLight()
//
//        ambientLight.type = .omni
//        ambientLight.color = UIColor.white
//        ambientLight.intensity = 100
//
//        ambientLightNode.light = ambientLight
//
//        ambientLightNode.position = SCNVector3(x: 0, y: 2, z: 0)
//
//        rootNode.addChildNode(ambientLightNode)
        // Add ambient light.
                let ambientLightNode = SCNNode()
                let ambientLight = SCNLight()

                ambientLight.type = .ambient
                ambientLight.color = UIColor.white
                ambientLight.intensity = 1000

                ambientLightNode.light = ambientLight

                rootNode.addChildNode(ambientLightNode)

                // Add spot light.
//                let spotLightNode = SCNNode()
//                let spotLight = SCNLight()
//
//                spotLight.type = .spot
//                spotLight.color = UIColor.white
//                spotLight.intensity = 1000
//                spotLight.spotInnerAngle = 20
//                spotLight.spotOuterAngle = 272
//                spotLight.castsShadow = true
//
//                spotLightNode.light = spotLight
//                spotLightNode.position = SCNVector3(-1, 2, 0)
//                spotLightNode.eulerAngles = SCNVector3(-Float.pi / 2, 0, 0)

//                rootNode.addChildNode(spotLightNode)
    }

    func setupDice() {
        let dieScene = SCNScene(named: "Assets.scnassets/Die.scn")!
        let dieNode = dieScene.rootNode.childNode(withName: "Dice", recursively: true)!

        let die1 = dieNode.clone()
        let die2 = dieNode.clone()
        let die3 = dieNode.clone()
        let die4 = dieNode.clone()
        let die5 = dieNode.clone()

        rootNode.addChildNode(die1)
        rootNode.addChildNode(die2)
        rootNode.addChildNode(die3)
        rootNode.addChildNode(die4)
        rootNode.addChildNode(die5)

        die1.position = SCNVector3(-1, 0, 0)
        die2.position = SCNVector3(-0.5, 0, 0)
        die3.position = SCNVector3(0, 0, 0)
        die4.position = SCNVector3(0.5, 0, 0)
        die5.position = SCNVector3(1, 0, 0)

        die1.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 2 * CGFloat.pi, y: 0, z: 0, duration: 1)))
        die2.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2 * CGFloat.pi, z: 0, duration: 1)))
        die3.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 0, z: 2 * CGFloat.pi, duration: 1)))
        die4.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 2 * CGFloat.pi, y: 0, z: 0, duration: 1)))
        die5.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2 * CGFloat.pi, z: 0, duration: 1)))
    }
}

class Poop {
    private var foo = "bar"; //semicolons are awesome
}
