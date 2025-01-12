import SwiftUI

public extension KeyboardShortcut {
	static let new = Self("n", modifiers: [.command])

	static let open = Self("o", modifiers: [.command])

	static let info = Self("i", modifiers: [.command])

	static let settings = Self(",", modifiers: [.command])
}
