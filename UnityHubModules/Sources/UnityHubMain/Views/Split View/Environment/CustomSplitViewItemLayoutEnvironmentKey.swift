import SwiftUI

extension EnvironmentValues {
	fileprivate(set) var customSplitViewItemLayout: [NSSplitViewItem.Behavior: CustomSplitViewItemLayout] {
		get { self[__Key_customSplitViewItemLayout.self] }
		set { self[__Key_customSplitViewItemLayout.self] = newValue }
	}

	private enum __Key_customSplitViewItemLayout: EnvironmentKey {
		static let defaultValue: [NSSplitViewItem.Behavior: CustomSplitViewItemLayout] = [:]
	}
}

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
