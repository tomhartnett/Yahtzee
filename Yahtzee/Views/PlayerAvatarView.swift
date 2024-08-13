//
//  PlayerAvatarView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/13/24.
//

import SwiftUI

struct PlayerAvatarView: View {
    var image: Image

    var body: some View {
        image
            .resizable()
            .frame(width: 50, height: 50)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 16) {
            PlayerAvatarView(image: Image("RandomBot"))
            PlayerAvatarView(image: Image("BetterBot"))
            PlayerAvatarView(image: Image("LuckyBot"))
        }
    }
}
