//
//  PrereleaseTag.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/30/20.
//

import SwiftUI

struct PrereleaseTag: View {
    var version: UnityVersion
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16, style: .circular)
            .frame(width: 48, height: 24)
            .foregroundColor(Color.systemGray4)
            .overlay(
                Text(version.isAlpha() ? "Alpha" : "Beta")
                    .foregroundColor(.textColor)
            )
    }
}
