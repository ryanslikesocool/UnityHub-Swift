//
//  Slot.swift
//  
//
//  Created by Enes Karaosman on 9.05.2020.
//

import SwiftUI

public struct Slot: Identifiable {
    /// Id
    public let id = UUID()
    /// The Icon will be displayed.
    public let image: () -> AnyView
    /// To allow modification on Text, wrap it with AnyView.
    public let title: () -> AnyView
    /// Tap Action
    public let action: () -> Void
    /// Style
    public let style: SlotStyle
    
    public init(
        image : @escaping () -> AnyView,
        title : @escaping () -> AnyView,
        action: @escaping () -> Void,
        style : SlotStyle
    ) {
        self.image = image
        self.title = title
        self.action = action
        self.style = style
    }
}

public struct SlotStyle {
    /// Background color of slot.
    public let background: Color
    /// Image tint color
    public let imageColor: Color
    /// Individual slot width
    public let slotWidth: CGFloat
    /// Individual slot height
    public let slotHeight: CGFloat
    
    public init(background: Color, imageColor: Color = .white, slotWidth: CGFloat = 60, slotHeight: CGFloat = 48) {
        self.background = background
        self.imageColor = imageColor
        self.slotWidth = slotWidth
        self.slotHeight = slotHeight
    }
}
