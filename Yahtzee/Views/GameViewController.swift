//
//  GameViewController.swift
//  YDice
//
//  Created by Tom Hartnett on 10/12/24.
//

import UIKit
import QuartzCore
import SceneKit
import YahtzeeKit

enum ControlInput {
    case reset
    case roll
}

protocol GameViewControllerDelegate: AnyObject {}

class GameViewController: UIViewController {

    var die1: SCNNode!
    var die2: SCNNode!
    var die3: SCNNode!
    var die4: SCNNode!
    var die5: SCNNode!

    weak var delegate: GameViewControllerDelegate?

    override func loadView() {
        view = SCNView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        let scene = SCNScene(named: "DiceArt.scnassets/dice.scn")!

        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 2.5)

        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)

        die1 = makeDieNode()
        die1.name = "die1"

        die2 = makeDieNode()
        die2.name = "die2"

        die3 = makeDieNode()
        die3.name = "die3"

        die4 = makeDieNode()
        die4.name = "die4"

        die5 = makeDieNode()
        die5.name = "die5"

        scene.rootNode.addChildNode(die1)
        scene.rootNode.addChildNode(die2)
        scene.rootNode.addChildNode(die3)
        scene.rootNode.addChildNode(die4)
        scene.rootNode.addChildNode(die5)

        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene

        // allows the user to manipulate the camera
        scnView.allowsCameraControl = false

        // show statistics such as fps and timing information
        scnView.showsStatistics = false

        // configure the view
        scnView.backgroundColor = UIColor.systemBackground

        resetDice(0)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    func handleInput(_ input: ControlInput) {
        switch input {
        case .reset:
            resetDice()
        case .roll:
            rollDice()
        }
    }

    func resetDice(_ duration: TimeInterval = 0.25) {
        die1.runAction(SCNAction.move(to: SCNVector3(-2.5, -10, -1), duration: duration))
        die2.runAction(SCNAction.move(to: SCNVector3(-1.25, -10, -1), duration: duration))
        die3.runAction(SCNAction.move(to: SCNVector3(0, -10, -1), duration: duration))
        die4.runAction(SCNAction.move(to: SCNVector3(1.25, -10, -1), duration: duration))
        die5.runAction(SCNAction.move(to: SCNVector3(2.5, -10, -1), duration: duration))

        die1.runAction(SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: duration))
        die2.runAction(SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: duration))
        die3.runAction(SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: duration))
        die4.runAction(SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: duration))
        die5.runAction(SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: duration))
    }

    func rollDice() {
        rollDie(die1)
        rollDie(die2)
        rollDie(die3)
        rollDie(die4)
        rollDie(die5)
    }

    private func makeDieNode() -> SCNNode {
        let dieNode = SCNNode()
        let dieGeometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.1)

        let material1 = SCNMaterial()
        material1.diffuse.contents = UIImage(named: "die-face-1")!

        let material2 = SCNMaterial()
        material2.diffuse.contents = UIImage(named: "die-face-2")!

        let material3 = SCNMaterial()
        material3.diffuse.contents = UIImage(named: "die-face-3")!

        let material4 = SCNMaterial()
        material4.diffuse.contents = UIImage(named: "die-face-4")!

        let material5 = SCNMaterial()
        material5.diffuse.contents = UIImage(named: "die-face-5")!

        let material6 = SCNMaterial()
        material6.diffuse.contents = UIImage(named: "die-face-6")!

        // Order the materials is applied matters to match real dice.
        dieGeometry.materials = [
            material1,
            material5,
            material6,
            material2,
            material4,
            material3
        ]

        dieNode.geometry = dieGeometry

        return dieNode
    }

    private func rollDie(_ die: SCNNode) {
        let finalValue = DieValue.random()
        let finalRotation = rotation(for: finalValue)
        let resetAction = SCNAction.rotateTo(x: CGFloat.randomRotation(), y: 0, z: 0, duration: 0)
        let initialAction = SCNAction.rotateBy(x: -CGFloat.pi * 2, y: CGFloat.pi, z: 0, duration: 0.5)
        let finalAction = SCNAction.rotateTo(
            x: CGFloat(finalRotation.x),
            y: CGFloat(finalRotation.y),
            z: CGFloat(finalRotation.z),
            duration: 0.25,
            usesShortestUnitArc: true
        )
        let sequence = SCNAction.sequence([resetAction, initialAction, finalAction])

        if die1.position.y < -5 {
            die1.runAction(SCNAction.move(to: SCNVector3(-2.5, 0, -1), duration: 0.5))
            die2.runAction(SCNAction.move(to: SCNVector3(-1.25, 0, -1), duration: 0.5))
            die3.runAction(SCNAction.move(to: SCNVector3(0, 0, -1), duration: 0.5))
            die4.runAction(SCNAction.move(to: SCNVector3(1.25, 0, -1), duration: 0.5))
            die5.runAction(SCNAction.move(to: SCNVector3(2.5, 0, -1), duration: 0.5))
        }

        die.runAction(sequence)
    }

    private func rotation(for dieValue: DieValue) -> SCNVector3 {
        switch dieValue {
        case .one:
            return SCNVector3(x: 0, y: 0, z: 0)
        case .two:
            return SCNVector3(x: 0, y: .pi / 2, z: 0)
        case .three:
            return SCNVector3(x: -.pi / 2, y: 0, z: 0)
        case .four:
            return SCNVector3(x: -2 * .pi / 2, y: 0, z: 0)
        case .five:
            return SCNVector3(x: 0, y: -.pi / 2, z: 0)
        case .six:
            return SCNVector3(x: -2 * .pi, y: 0, z: 0)
        }
    }
}

extension CGFloat {
    static func randomRotation() -> CGFloat {
        let lower: CGFloat = 0
        let upper: CGFloat = .pi * 2
        return .random(in: lower...upper)
    }
}
