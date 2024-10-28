import SwiftUI

public extension KeyboardShortcut {
	static let new: Self = Self("n", modifiers: [.command])
	static let open: Self = Self("o", modifiers: [.command])
	static let info: Self = Self("i", modifiers: [.command])
	static let settings: Self = Self(",", modifiers: [.command])
}
