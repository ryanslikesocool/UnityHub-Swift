//
//  PrereleaseTag.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/30/20.
//

import SwiftUI

struct PrereleaseTag: View {
    var version: UnityVersion
    var small: Bool = false
    
    var body: some View {
        let isAlpha: Bool = version.isAlpha()
        let isLts: Bool = version.lts && !version.isPrerelease()
        let labelText: String = isLts ? "LTS" : isAlpha ? "Alpha" : "Beta"
        let borderColor: Color = Color(isLts ? NSColor.systemGreen : isAlpha ? NSColor.systemRed : NSColor.systemYellow)
        
        if small {
            return RoundedRectangle(cornerRadius: 4, style: .circular)
                .stroke(borderColor, lineWidth: 2)
                .frame(width: 40, height: 16)
                .overlay(
                    Text(labelText)
                        .font(.caption)
                )
        } else {
            return RoundedRectangle(cornerRadius: 6, style: .circular)
                .stroke(borderColor, lineWidth: 2)
                .frame(width: 48, height: 24)
                .overlay(
                    Text(labelText)
                )
        }
    }
}

struct PrereleaseTag_Previews: PreviewProvider {
    static var previews: some View {
        PrereleaseTag(version: UnityVersion("2020.1.0b1"))
        PrereleaseTag(version: UnityVersion("2020.1.0a1"))
        PrereleaseTag(version: UnityVersion("2020.3.0f1"))
        PrereleaseTag(version: UnityVersion("2020.3.0b1"))
    }
}
