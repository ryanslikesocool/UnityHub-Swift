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
        UnityButton(configuration: configuration, cornerRadius: cornerRadius, backgroundColor: backgroundColor, verticalPadding: verticalPadding, horizontalPadding: horizontalPadding)
    }
    
    struct UnityButton: View {
        @Environment(\.isEnabled) private var isEnabled: Bool
        let configuration: ButtonStyle.Configuration
        var cornerRadius: CGFloat?
        var backgroundColor: Color?
        var verticalPadding: CGFloat?
        var horizontalPadding: CGFloat?
        
        var body: some View {
            return configuration.label
                .padding(.vertical, verticalPadding ?? 8)
                .padding(.horizontal, horizontalPadding ?? 16)
                .background(
                    (backgroundColor ?? Color.systemGray5)!.multiply(v: isEnabled ? 1 : 0.5).multiply(v: configuration.isPressed ? 0.75 : 1)
                )
                //.cornerRadius(cornerRadius ?? 8)
                .mask(RoundedRectangle(cornerRadius: cornerRadius ?? 8, style: .continuous))
                //.shadow(radius: 2)
                .animation(.easeIn, value: configuration.isPressed)
                .animation(.easeIn, value: isEnabled)
        }
    }
}
