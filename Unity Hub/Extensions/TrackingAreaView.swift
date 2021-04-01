//
//  TrackingAreaView.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 4/1/21.
//

import AppKit
import Foundation
import SwiftUI

extension View {
    func trackingMouse(onMove: @escaping (NSPoint, NSPoint) -> Void) -> some View {
        TrackingAreaView(onMove: onMove) { self }
    }
}

struct TrackingAreaView<Content: View>: View {
    let onMove: (NSPoint, NSPoint) -> Void
    let content: () -> Content
    
    init(onMove: @escaping (NSPoint, NSPoint) -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.onMove = onMove
        self.content = content
    }
    
    var body: some View {
        TrackingAreaRepresentable(onMove: onMove, content: self.content())
    }
}

struct TrackingAreaRepresentable<Content: View>: NSViewRepresentable {
    let onMove: (NSPoint, NSPoint) -> Void
    let content: Content
    
    func makeNSView(context: Context) -> NSHostingView<Content> {
        return TrackingNSHostingView(onMove: self.onMove, rootView: self.content)
    }
    
    func updateNSView(_ nsView: NSHostingView<Content>, context: Context) {}
}

class TrackingNSHostingView<Content: View>: NSHostingView<Content> {
    let onMove: (NSPoint, NSPoint) -> Void
    
    init(onMove: @escaping (NSPoint, NSPoint) -> Void, rootView: Content) {
        self.onMove = onMove
        
        super.init(rootView: rootView)
        
        self.setupTrackingArea()
    }
    
    required init(rootView: Content) {
        fatalError("init(rootView:) has not been implemented")
    }
    
    @available(*, unavailable)
    @objc dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTrackingArea() {
        let options: NSTrackingArea.Options = [.mouseMoved, .activeAlways, .inVisibleRect]
        self.addTrackingArea(NSTrackingArea(rect: .zero, options: options, owner: self, userInfo: nil))
    }
        
    override func mouseMoved(with event: NSEvent) {
        //if event.allTouches().count == 2 {
            self.onMove(self.convert(event.locationInWindow, from: nil), NSPoint(x: event.deltaX, y: event.deltaY))
        //}
    }
}
