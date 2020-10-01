//
//  ButtonStyle.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 10/1/20.
//

import SwiftUI

struct UnityButtonStyle: ButtonStyle {
    var cornerRadius: CGFloat?
    var backgroundColor: Color?
    var verticalPadding: CGFloat?
    var horizontalPadding: CGFloat?

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.vertical, verticalPadding ?? 8)
            .padding(.horizontal, horizontalPadding ?? 16)
            .background(backgroundColor ?? Color.systemGray6)
            .mask(RoundedRectangle(cornerRadius: cornerRadius ?? 8, style: .continuous))
    }
}
