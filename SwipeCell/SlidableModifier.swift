//
//  SlidableModifier.swift
//  
//
//  Created by Enes Karaosman on 10.05.2020.
//

import SwiftUI

public struct SlidableModifier: ViewModifier, Animatable {
    
    public enum SlideAxis {
        case leftToRight
        case rightToLeft
    }
    
    private var contentOffset: CGSize {
        switch self.slideAxis {
        case .leftToRight:
            return .init(width: self.currentSlotsWidth, height: 0)
        case .rightToLeft:
            return .init(width: -self.currentSlotsWidth, height: 0)
        }
    }
    
    private var slotOffset: CGSize {
        switch self.slideAxis {
        case .leftToRight:
            return .init(width: self.currentSlotsWidth - self.totalSlotWidth, height: 0)
        case .rightToLeft:
            return .init(width: self.totalSlotWidth - self.currentSlotsWidth, height: 0)
        }
    }
    
    private var zStackAlignment: Alignment {
        switch self.slideAxis {
        case .leftToRight:
            return .leading
        case .rightToLeft:
            return .trailing
        }
    }
    
    /// Animated slot widths of total
    @State var currentSlotsWidth: CGFloat = 0
    
    /// To restrict the bounds of slots
    private func optWidth(value: CGFloat) -> CGFloat {
        return min(abs(value), totalSlotWidth)
    }
    
    public var animatableData: Double {
        get { Double(self.currentSlotsWidth) }
        set { self.currentSlotsWidth = CGFloat(newValue) }
    }
    
    private var totalSlotWidth: CGFloat {
        return slots.map { $0.style.slotWidth }.reduce(0, +)
    }
    
    private var slots: [Slot] {
        slideAxis == .leftToRight ? leadingSlots : trailingSlots
    }
    
    @State private var slideAxis: SlideAxis = SlideAxis.leftToRight
    private var leadingSlots: [Slot]
    private var trailingSlots: [Slot]
    
    public init(leading: [Slot], trailing: [Slot]) {
        self.leadingSlots = leading
        self.trailingSlots = trailing
    }
    
    private func flushState() {
        withAnimation {
            self.currentSlotsWidth = 0
        }
    }
    
    public func body(content: Content) -> some View {
        ZStack(alignment: self.zStackAlignment) {
            content
            .offset(self.contentOffset)
            .onTapGesture(perform: flushState)
            
            slotContainer
            .offset(self.slotOffset)
            .frame(width: self.totalSlotWidth)
        }
        .gesture(gesture)
    }
    
    // MARK: Slot Container
    private var slotContainer: some View {
        HStack(spacing: 4) {
            ForEach(self.slots) { slot in
                VStack(spacing: 4) {
                    Spacer() // To extend top edge
                    
                    slot.image()
                        .foregroundColor(slot.style.imageColor)
                    
                    slot.title()
                    
                    Spacer() // To extend bottom edge
                }
                .frame(width: slot.style.slotWidth)
                .background(slot.style.background)
                .onTapGesture {
                    slot.action()
                    self.flushState()
                }
                .mask(RoundedRectangle(cornerRadius: 4))
            }
        }
    }
    
    // MARK: - Drag Gesture
    private var gesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let amount = value.translation.width
                
                if amount < 0 {
                    self.slideAxis = .rightToLeft
                } else {
                    self.slideAxis = .leftToRight
                }
                withAnimation(.interactiveSpring(), { self.currentSlotsWidth = self.optWidth(value: amount) })
            }
            .onEnded { value in
                withAnimation(.interactiveSpring(), {
                    if self.currentSlotsWidth < (self.totalSlotWidth / 2) {
                        self.currentSlotsWidth = 0
                    } else {
                        self.currentSlotsWidth = self.totalSlotWidth
                    }
                })
            }
    }
    
}
