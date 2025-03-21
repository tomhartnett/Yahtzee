//
//  DiceViewController.swift
//  YDice
//
//  Created by Tom Hartnett on 10/12/24.
//

import UIKit
import QuartzCore
import SceneKit
import YahtzeeKit

protocol DiceViewControllerDelegate: AnyObject {
    func didToggleDieHold(_ slot: DieSlot, isHeld: Bool)
    func rollingDidComplete(_ dice: DiceValues, tuple: ScoreTuple?)
}

class DiceViewController: UIViewController {

    var die1: DieNode!
    var die2: DieNode!
    var die3: DieNode!
    var die4: DieNode!
    var die5: DieNode!

    weak var delegate: DiceViewControllerDelegate?

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

        die1 = makeDieNode(dieSlot: .one)
        die2 = makeDieNode(dieSlot: .two)
        die3 = makeDieNode(dieSlot: .three)
        die4 = makeDieNode(dieSlot: .four)
        die5 = makeDieNode(dieSlot: .five)

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

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        scnView.addGestureRecognizer(tapGesture)

        resetDice()
    }

    func resetDice() {
        die1.position = SCNVector3(-2.5, 0, 0)
        die2.position = SCNVector3(-1.25, 0, 0)
        die3.position = SCNVector3(0, 0, 0)
        die4.position = SCNVector3(1.25, 0, 0)
        die5.position = SCNVector3(2.5, 0, 0)

        die1.reset()
        die2.reset()
        die3.reset()
        die4.reset()
        die5.reset()
    }

    func rollDice(_ dice: DiceValues, tuple: ScoreTuple? = nil) {
        rollDie(die1, dieValue: dice.value1)
        rollDie(die2, dieValue: dice.value2)
        rollDie(die3, dieValue: dice.value3)
        rollDie(die4, dieValue: dice.value4)
        rollDie(die5, dieValue: dice.value5)

        // HACK: wait for animations duration then signal rolling complete.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            self.delegate?.rollingDidComplete(dice, tuple: tuple)
        }
    }

    private func makeDieNode(dieSlot: DieSlot) -> DieNode {
        let dieNode = DieNode(dieSlot: dieSlot)
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

    private func rollDie(_ die: DieNode, dieValue: DieValue) {
        guard !die.isHeld else { return }

        die.isHidden = false
        let finalRotation = rotation(for: dieValue)
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
            return SCNVector3(x: -(3 * .pi) / 2, y: 0, z: 0)
        case .five:
            return SCNVector3(x: 0, y: -.pi / 2, z: 0)
        case .six:
            return SCNVector3(x: -.pi, y: 0, z: 0)
        }
    }

    @objc
    private func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
        let scnView = self.view as! SCNView
        let p = gestureRecognizer.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        if let dieNode = hitResults.first?.node as? DieNode {
            dieNode.isHeld.toggle()
            delegate?.didToggleDieHold(dieNode.dieSlot, isHeld: dieNode.isHeld)
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
