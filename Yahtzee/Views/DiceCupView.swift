//
//  DiceCupView.swift
//  Yahtzee
//
//  Created by Tom Hartnett on 8/3/24.
//

import SwiftUI
import YahtzeeKit

struct DiceCupView: View {
    @Binding var diceCup: DiceCup

    var body: some View {
        HStack {
            Spacer()
            
            DieView(die: diceCup.die1)
                .onTapGesture {
                    diceCup.hold(.one)
                }

            Spacer()

            DieView(die: diceCup.die2)
                .onTapGesture {
                    diceCup.hold(.two)
                }

            Spacer()

            DieView(die: diceCup.die3)
                .onTapGesture {
                    diceCup.hold(.three)
                }

            Spacer()

            DieView(die: diceCup.die4)
                .onTapGesture {
                    diceCup.hold(.four)
                }

            Spacer()

            DieView(die: diceCup.die5)
                .onTapGesture {
                    diceCup.hold(.five)
                }

            Spacer()
        }
    }
}

#Preview {
    DiceCupView(diceCup: .constant(DiceCup()))
}
