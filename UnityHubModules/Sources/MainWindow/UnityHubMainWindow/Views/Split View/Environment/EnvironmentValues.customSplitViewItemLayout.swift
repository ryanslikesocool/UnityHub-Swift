import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var customSplitViewItemLayout: [NSSplitViewItem.Behavior: CustomSplitViewItemLayout]
		= [:]
}

// MARK: - Convenience

extension View {
	func customSplitViewItemLayout(
		_ behavior: NSSplitViewItem.Behavior,
		min: CGFloat? = nil,
		max: CGFloat? = nil,
		collapsible: Bool? = nil
	) -> some View {
		environment(
			\.customSplitViewItemLayout[behavior],
			CustomSplitViewItemLayout(
				behavior,
				min: min,
				max: max,
				collapsible: collapsible
			)
		)
	}

	func customSplitViewItemLayout(
		_ behavior: NSSplitViewItem.Behavior,
		_ value: CGFloat,
		collapsible: Bool? = nil
	) -> some View {
		customSplitViewItemLayout(
			behavior,
			min: value,
			max: value,
			collapsible: collapsible
		)
	}
}
