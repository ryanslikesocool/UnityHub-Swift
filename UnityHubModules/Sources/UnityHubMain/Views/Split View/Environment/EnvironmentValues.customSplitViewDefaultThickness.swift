import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var customSplitViewDefaultThickness: [NSSplitViewItem.Behavior: CGFloat]
		= [:]
}

// MARK: - Convenience

extension View {
	func customSplitViewDefaultThickness(_ behavior: NSSplitViewItem.Behavior, _ value: CGFloat) -> some View {
		environment(\.customSplitViewDefaultThickness[behavior], value)
	}
}
