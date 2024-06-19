//
//  ContentView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 6/16/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
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

            HStack {
                DieHolderView()
                DieHolderView()
                DieHolderView()
                DieHolderView()
                DieHolderView()
            }
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

struct DieHolderView: View {
    @State private var value = ""

    var body: some View {
        Text(value)
            .frame(width: 50, height: 50)
            .border(.black)
    }
}
