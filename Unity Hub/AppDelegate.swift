import AppKit
import Foundation
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSWindow.allowsAutomaticWindowTabbing = false
        AppDelegate.setAppearance(from: EditorSettings.shared.general.appearance.rawValue)
    }

    static func setAppearance(from string: String) {
        setAppearance(ColorScheme(from: string))
    }

    private static func setAppearance(_ theme: ColorScheme?) {
        Async.main {
            NSApp.appearance = theme?.toAppearance() ?? nil
        }
    }

    static func closeWindow(_ window: NSWindow) {
        Async.main {
            window.close()
        }
    }
}
