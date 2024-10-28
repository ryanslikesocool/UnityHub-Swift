import SwiftUI

@available(macOS 15, iOS 18, tvOS 18, watchOS 11, *)
extension ContainerValues {
	fileprivate(set) var ignoresEqualSizeLayout: Axis.Set {
		get { self[__Key_ignoresEqualSizeLayout.self] }
		set { self[__Key_ignoresEqualSizeLayout.self] = newValue }
	}

	enum __Key_ignoresEqualSizeLayout: ContainerValueKey {
		static let defaultValue: Axis.Set = []
	}
}

// MARK: - Convenience

public extension View {
	@available(macOS 15, iOS 18, tvOS 18, watchOS 11, *)
	func ignoresEqualSizeLayout(_ axis: Axis.Set = [.horizontal, .vertical]) -> some View {
		containerValue(\.ignoresEqualSizeLayout, axis)
	}
}
