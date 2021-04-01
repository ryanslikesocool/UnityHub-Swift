//
//  SwipeActionView.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 4/1/21.
//

import SwiftUI

struct SwipeActionView<Content: View>: View {
    @State private var sideOpen: HorizontalAlignment = .center
    @GestureState private var translation: CGFloat = 0

    let leadingItems: [SwipeActionButton]
    let trailingItems: [SwipeActionButton]

    let content: Content

    private var offset: CGFloat {
        switch sideOpen {
        case .leading: return CGFloat.swipeActionButtonWidth * CGFloat(leadingItems.count)
        case .trailing: return -CGFloat.swipeActionButtonWidth * CGFloat(trailingItems.count)
        default: return 0
        }
    }

    init(leadingItems: [SwipeActionButton] = [], trailingItems: [SwipeActionButton] = [], @ViewBuilder content: () -> Content) {
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
        self.content = content()
    }

    var body: some View {
        GeometryReader { _ in
            HStack(spacing: 0) {}
                .offset(x: offset)
                .animation(.interactiveSpring(), value: sideOpen)
                .animation(.interactiveSpring(), value: translation)
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.height
                    }.onEnded { value in
                        guard abs(value.translation.width) > .swipeActionButtonWidth * 0.75 else {
                            return
                        }
                        sideOpen = value.translation.width < 0 ? .trailing : .leading
                    }
                )
        }
    }
}
