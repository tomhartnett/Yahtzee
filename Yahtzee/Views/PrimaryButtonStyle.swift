//
//  PrimaryButtonStyle.swift
//  LitterReminder
//
//  Created by Tom Hartnett on 11/17/24.
//

import SwiftUI

struct PrimaryButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.trigger()
        }) {
            configuration.label
                .font(.title3)
                .fontWeight(.bold)
                .padding(.vertical)
                .padding(.horizontal, 32)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

struct SecondaryButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.trigger()
        }) {
            configuration.label
                .font(.title3)
                .fontWeight(.medium)
                .underline()
                .padding(.vertical)
                .padding(.horizontal, 32)
        }
    }
}

#Preview {
    VStack(alignment: .leading) {
        Button(action: {}) {
            Text("Mark Complete")
        }
        .buttonStyle(PrimaryButtonStyle())

        Button(action: {}) {
            Text("Snooze 1 day")
        }
        .buttonStyle(PrimaryButtonStyle())

        Button(action: {}) {
            Text("Remind me in 2 days")
        }
        .buttonStyle(PrimaryButtonStyle())

        HStack {
            Button(action: {}) {
                Text("Cancel")
            }
            .buttonStyle(SecondaryButtonStyle())

            Button(action: {}) {
                Text("Confirm")
            }
            .buttonStyle(PrimaryButtonStyle())
        }
    }
}
