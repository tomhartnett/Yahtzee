//
//  NewGameView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/27/24.
//

import SwiftUI
import YahtzeeKit

struct NewGameView: View {
    @Environment(\.dismiss) var dismiss

    @State private var scrolledID: BotSkillLevel.ID?

    var initialSkillLevel: BotSkillLevel

    var didSelect: (BotSkillLevel) -> Void

    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                VStack {
                    Text("New Game")
                        .font(.title)

                    Text("Choose Opponent")

                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(BotSkillLevel.allCases) { skillLevel in
                                VStack {
                                    image(for: skillLevel)
                                        .resizable()
                                        .frame(width: proxy.size.width * 0.7, height: proxy.size.width * 0.7)
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(RoundedRectangle(cornerRadius: 25))

                                    Text(name(for: skillLevel))
                                        .italic()
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $scrolledID)
                    .safeAreaPadding(.horizontal, 40)

                    Button(action: {
                        guard let skillLevel = scrolledID else { return }
                        didSelect(skillLevel)
                        dismiss()
                    }) {
                        Text("Play")
                            .frame(width: proxy.size.width * 0.7)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .tint(.primary)
                        }
                    }
                }
                .onAppear {
                    scrolledID = initialSkillLevel
                }
            }
        }
    }

    func image(for skillLevel: BotSkillLevel) -> Image {
        switch skillLevel {
        case .bad:
            return Image("Unskilled Dummy Bot")
        case .ok:
            return Image("Meh Bot")
        case .great:
            return Image("Hard Bot")
        }
    }

    func name(for skillLevel: BotSkillLevel) -> String {
        switch skillLevel {
        case .bad:
            return "Unskilled Dummy Bot"
        case .ok:
            return "Meh Bot"
        case .great:
            return "Hard Bot"
        }
    }
}

#Preview {
    VStack {
        Text("Hello World")
    }
    .sheet(isPresented: .constant(true)) {
        NewGameView(initialSkillLevel: .great) { _ in }
    }
}
