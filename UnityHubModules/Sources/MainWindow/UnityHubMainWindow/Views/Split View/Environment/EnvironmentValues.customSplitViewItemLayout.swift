import SwiftUI

extension EnvironmentValues {
	/// ## See Also
	/// - ``SwiftUICore/View/customSplitViewItemLayout(_:min:max:collapsible:)``
	/// - ``SwiftUICore/View/customSplitViewItemLayout(_:_:collapsible:)``
	@Entry
	fileprivate(set) var customSplitViewItemLayout: [NSSplitViewItem.Behavior: CustomSplitViewItemLayout]
		= [:]
}

// MARK: - Convenience

extension View {
	/// ## See Also
	/// - ``SwiftUICore/EnvironmentValues/customSplitViewItemLayout``
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

	/// ## See Also
	/// - ``SwiftUICore/EnvironmentValues/customSplitViewItemLayout``
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
