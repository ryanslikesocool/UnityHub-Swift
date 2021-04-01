//
//  SwipeActionButton.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 4/1/21.
//

import SwiftUI

struct SwipeActionButton: View {
    let symbol: Image
    let color: Color
    let action: () -> Void

    init(symbol: Image, color: Color, action: @escaping () -> Void) {
        self.symbol = symbol
        self.color = color
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            VStack(alignment: .center) {
                Spacer()
                symbol
                Spacer()
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(color)
        )
        .buttonStyle(PlainButtonStyle())
        .frame(width: .swipeActionButtonWidth)
    }
}
