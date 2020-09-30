//
//  VisualEffectView.swift
//  HyperCalc
//
//  Created by Ryan Boyer on 8/17/20.
//

import SwiftUI
import AppKit

struct VisualEffectView: NSViewRepresentable {
    var material: NSVisualEffectView.Material
    var blendingMode: NSVisualEffectView.BlendingMode = .withinWindow
    var emphasized: Bool = false
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        NSVisualEffectView()
    }
    
    func updateNSView(_ view: NSVisualEffectView, context: Context) {
        view.material = material
        view.blendingMode = blendingMode
        view.isEmphasized = emphasized
    }
}
