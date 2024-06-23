//
//  ContentView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/16/24.
//

import SwiftUI
import YahtzeeKit

struct ContentView: View {
    @State private var viewModel = ViewModel()

    var body: some View {
        VStack(spacing: 64) {
            HStack {
                VStack {
                    CategoryScoreView(label: "1s")
                    CategoryScoreView(label: "2s")
                    CategoryScoreView(label: "3s")
                    CategoryScoreView(label: "4s")
                    CategoryScoreView(label: "5s")
                    CategoryScoreView(label: "6s")
                    CategoryScoreView(label: "Bonus")
                }
                
                Spacer()

                VStack {
                    CategoryScoreView(label: "3ofKind")
                    CategoryScoreView(label: "4ofKind")
                    CategoryScoreView(label: "fullHouse")
                    CategoryScoreView(label: "smStraight")
                    CategoryScoreView(label: "lgStraight")
                    CategoryScoreView(label: "Yahtzee")
                    CategoryScoreView(label: "Chance")
                }
            }

            RolledDiceView(
                die1: viewModel.die1,
                die2: viewModel.die2,
                die3: viewModel.die3,
                die4: viewModel.die4,
                die5: viewModel.die5
            )

            Button(action: {
                viewModel.roll()
            }, label: {
                HStack(spacing: 16) {
                    Text("Roll")

                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(viewModel.remainingRolls >= 1 ? .blue : .clear)

                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(viewModel.remainingRolls >= 2 ? .blue : .clear)

                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(viewModel.remainingRolls == 3 ? .blue : .clear)
                }
                .frame(maxWidth: .infinity, minHeight: 50)
                .border(.black)
            })

            Spacer()
        }
        .padding()
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
