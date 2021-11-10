import SwiftUI

extension ColorScheme {
    #if canImport(AppKit)
        func toAppearance() -> NSAppearance? {
            switch self {
            case .light: return NSAppearance(named: .aqua)!
            case .dark: return NSAppearance(named: .darkAqua)!
            default: return nil
            }
        }
    #else
        func toAppearance() -> UIUserInterfaceStyle {
            switch self {
            case .light: return .light
            case .dark: return .dark
            default: return .unspecified
            }
        }
    #endif

    init?(from string: String) {
        switch string {
        case "Light": self = .light
        case "Dark": self = .dark
        default: return nil
        }
    }
}
