//
//  UnityModule.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import Foundation
import SwiftUI

enum UnityModule {
    case macOSMono
    case macOSIL2CPP
    case windowsMono
    case windowsIL2CPP
    case linuxMono
    case linuxIL2CPP
    case iOS
    case tvOS
    case android
}

extension UnityModule: RawRepresentable {
    // (display name, json name, icon)
    typealias RawValue = (String, String, AnyView)
    
    init?(rawValue: (String, String, AnyView)) {
        switch rawValue.1 {
        case "mac-mono": self = .macOSMono
        case "mac-il2cpp": self = .macOSIL2CPP
        case "windows-mono": self = .windowsMono
        case "windows-il2cpp": self = .windowsIL2CPP
        case "linux-mono": self = .linuxMono
        case "linux-il2cpp": self = .linuxIL2CPP
        case "ios": self = .iOS
        case "appletv": self = .tvOS
        case "android": self = .android
        default: return nil
        }
    }
    
    var rawValue: (String, String, AnyView) {
        switch self {
        case .macOSMono: return ("macOS Mono", "mac-mono", AnyView(SVGShapes.macOS().frame(width: 20, height: 20)))
        case .macOSIL2CPP: return ("macOS IL2CPP", "mac-il2cpp", AnyView(SVGShapes.macOS().frame(width: 20, height: 20)))
        case .windowsMono: return ("Windows Mono", "windows-mono", AnyView(SVGShapes.Windows().frame(width: 20, height: 20)))
        case .windowsIL2CPP: return ("Windows IL2CPP", "windows-il2cpp", AnyView(SVGShapes.Windows().frame(width: 20, height: 20)))
        case .linuxMono: return ("Linux Mono", "linux-mono", AnyView(SVGShapes.Linux().frame(width: 20, height: 20)))
        case .linuxIL2CPP: return ("Linux IL2CPP", "linux-il2cpp", AnyView(SVGShapes.Linux().frame(width: 20, height: 20)))
        case .iOS: return ("iOS", "ios", AnyView(SVGShapes.iOS().frame(width: 20, height: 20)))
        case .tvOS: return ("tvOS", "appletv", AnyView(SVGShapes.tvOS().frame(width: 20, height: 20)))
        case .android: return ("Android", "android", AnyView(SVGShapes.Android().frame(width: 20, height: 20)))
        }
    }
}

extension UnityModule: CaseIterable, Identifiable {
    var id: String {
        return self.rawValue.1
    }
}
