import SwiftUI

extension EnvironmentValues {
	fileprivate(set) var customSplitViewColumnWidth: [NSSplitViewItem.Behavior: CustomSplitViewColumnWidth] {
		get { self[__Key_customSplitViewColumnWidth.self] }
		set { self[__Key_customSplitViewColumnWidth.self] = newValue }
	}

	private enum __Key_customSplitViewColumnWidth: EnvironmentKey {
		static let defaultValue: [NSSplitViewItem.Behavior: CustomSplitViewColumnWidth] = [:]
	}
}

extension View {
	func customSplitViewColumnWidth(_ column: NSSplitViewItem.Behavior, min: CGFloat? = nil, max: CGFloat? = nil) -> some View {
		environment(\.customSplitViewColumnWidth[column], CustomSplitViewColumnWidth(min: min, max: max))
	}

	func customSplitViewColumnWidth(_ column: NSSplitViewItem.Behavior, _ value: CGFloat) -> some View {
		customSplitViewColumnWidth(column, min: value, max: value)
	}
}
