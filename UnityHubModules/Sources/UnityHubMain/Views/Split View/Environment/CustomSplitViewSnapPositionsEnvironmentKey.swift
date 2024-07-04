import SwiftUI

extension EnvironmentValues {
	fileprivate(set) var customSplitViewSnapPositions: [Int: CustomSplitViewSnapPosition] {
		get { self[__Key_customSplitViewSnapPositions.self] }
		set { self[__Key_customSplitViewSnapPositions.self] = newValue }
	}

	private enum __Key_customSplitViewSnapPositions: EnvironmentKey {
		static let defaultValue: [Int: CustomSplitViewSnapPosition] = [:]
	}
}

extension View {
	func customSplitViewSnapPositions(index: Int, positions: [CGFloat]?, onChange: ((Int) -> Void)? = nil) -> some View {
		let value = CustomSplitViewSnapPosition(positions: positions, onChange: onChange)
		return environment(\.customSplitViewSnapPositions[index], value)
	}

	func customSplitViewSnap(index: Int, enabled: Bool, onChange: ((Int) -> Void)? = nil) -> some View {
		customSplitViewSnapPositions(index: index, positions: enabled ? [] : nil, onChange: onChange)
	}
}
