import SwiftUI

extension EnvironmentValues {
	/// ## See Also
	/// - ``SwiftUICore/View/customSplitViewSnapPositions(index:positions:onChange:)``
	/// - ``SwiftUICore/View/customSplitViewSnapPositions(index:enabled:onChange:)``
	@Entry
	fileprivate(set) var customSplitViewSnapPositions: [Int: CustomSplitViewSnapPosition]
		= [:]
}

// MARK: - Convenience

extension View {
	/// ## See Also
	/// - ``SwiftUICore/EnvironmentValues/customSplitViewSnapPositions``
	func customSplitViewSnapPositions(
		index: Int,
		positions: [CGFloat]?,
		onChange: ((Int) -> Void)? = nil
	) -> some View {
		let value = CustomSplitViewSnapPosition(positions: positions, onChange: onChange)
		return environment(\.customSplitViewSnapPositions[index], value)
	}

	/// ## See Also
	/// - ``SwiftUICore/EnvironmentValues/customSplitViewSnapPositions``
	func customSplitViewSnap(
		index: Int,
		enabled: Bool,
		onChange: ((Int) -> Void)? = nil
	) -> some View {
		customSplitViewSnapPositions(index: index, positions: enabled ? [] : nil, onChange: onChange)
	}
}
