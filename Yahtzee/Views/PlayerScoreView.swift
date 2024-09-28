//
//  PlayerScoreView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/19/24.
//

import SwiftUI

struct PlayerScoreView: View {
    var image: Image
    var score: Int
    var isRightAligned: Bool

    var body: some View {
        HStack(spacing: 8) {
            image
                .resizable()
                .frame(width: 50, height: 50)
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())

            Text("\(score)")
                .frame(width: 50)
                .font(.title)
                .minimumScaleFactor(0.1)
                .lineLimit(1)

            Spacer()
        }
        .environment(\.layoutDirection, isRightAligned ? .rightToLeft : .leftToRight)
    }
}

#Preview {
    HStack(spacing: 64) {
        PlayerScoreView(image: Image(systemName: "person.crop.circle"), score: 0, isRightAligned: false)
        PlayerScoreView(image: Image("LuckyBot"), score: 296, isRightAligned: true)
    }
}
