import SwiftUI
import UnityHubCommon

public extension Constant {
	enum Hotkey {
		public static let new: KeyboardShortcut = KeyboardShortcut("n", modifiers: [.command])
		public static let open: KeyboardShortcut = KeyboardShortcut("o", modifiers: [.command])
		public static let info: KeyboardShortcut = KeyboardShortcut("i", modifiers: [.command])
		public static let settings: KeyboardShortcut = KeyboardShortcut(",", modifiers: [.command])
	}
}
