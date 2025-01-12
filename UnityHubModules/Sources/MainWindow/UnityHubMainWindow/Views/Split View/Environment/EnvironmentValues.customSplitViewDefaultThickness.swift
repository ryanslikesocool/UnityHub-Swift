import SwiftUI

extension EnvironmentValues {
	/// ## See Also
	/// - ``SwiftUICore/View/customSplitViewDefaultThickness(_:_:)``
	@Entry
	fileprivate(set) var customSplitViewDefaultThickness: [NSSplitViewItem.Behavior: CGFloat]
		= [:]
}

// MARK: - Convenience

extension View {
	/// ## See Also
	/// - ``SwiftUICore/EnvironmentValues/customSplitViewDefaultThickness``
	func customSplitViewDefaultThickness(
		_ behavior: NSSplitViewItem.Behavior,
		_ value: CGFloat
	) -> some View {
		environment(\.customSplitViewDefaultThickness[behavior], value)
	}
}
