import SwiftUI

extension EnvironmentValues {
	fileprivate(set) var customSplitViewColumnWidth: [CustomSplitViewColumn: CustomSplitViewColumnWidth] {
		get { self[__Key_customSplitViewColumnWidth.self] }
		set { self[__Key_customSplitViewColumnWidth.self] = newValue }
	}

	private enum __Key_customSplitViewColumnWidth: EnvironmentKey {
		static let defaultValue: [CustomSplitViewColumn: CustomSplitViewColumnWidth] = [:]
	}
}

extension View {
	func customSplitViewColumnWidth(_ column: CustomSplitViewColumn, min: CGFloat? = nil, max: CGFloat? = nil) -> some View {
		environment(\.customSplitViewColumnWidth[column], CustomSplitViewColumnWidth(min: min, max: max))
	}

	func customSplitViewColumnWidth(_ column: CustomSplitViewColumn, _ value: CGFloat) -> some View {
		customSplitViewColumnWidth(column, min: value, max: value)
	}
}
