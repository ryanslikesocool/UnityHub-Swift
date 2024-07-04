import SwiftUI

extension EnvironmentValues {
	fileprivate(set) var customSplitViewDefaultThickness: [NSSplitViewItem.Behavior: CGFloat] {
		get { self[__Key_customSplitViewDefaultThickness.self] }
		set { self[__Key_customSplitViewDefaultThickness.self] = newValue }
	}

	private enum __Key_customSplitViewDefaultThickness: EnvironmentKey {
		static let defaultValue: [NSSplitViewItem.Behavior: CGFloat] = [:]
	}
}

extension View {
	func customSplitViewDefaultThickness(_ behavior: NSSplitViewItem.Behavior, _ value: CGFloat) -> some View {
		environment(\.customSplitViewDefaultThickness[behavior], value)
	}
}
