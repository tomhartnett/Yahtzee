//
//  ContentView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/16/24.
//

import SceneKit
import SwiftUI
import YahtzeeKit

struct ContentView: View {
    @State private var viewModel = ViewModel()

    let scene = DiceScene(named: "Assets.scnassets/RollDice.scn")!

    var body: some View {
        VStack {
            Text("Hello, 3D world!")
                .font(.largeTitle)
                .fontWeight(.bold)

            SceneView(scene: scene,
                      pointOfView: scene.cameraNode,
                      options: .allowsCameraControl)
            .border(.blue)
        }
    }
}

#Preview {
    ContentView()
}

struct CategoryScoreView: View {
    var label: String

    @State var score: String = " "

    var body: some View {
        HStack {
            Text(label)
                .frame(width: 100)
            Text(score)
                .frame(width: 50, height: 50)
                .border(.black)
        }
    }
}
