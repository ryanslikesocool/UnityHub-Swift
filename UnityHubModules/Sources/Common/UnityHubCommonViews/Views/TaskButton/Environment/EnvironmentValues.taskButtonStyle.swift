import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var taskButtonStyle: AnyTaskButtonStyle
		= AnyTaskButtonStyle(.default)
}

// MARK: - Convenience

public extension View {
	func taskButtonStyle(_ style: some TaskButtonStyle) -> some View {
		environment(\.taskButtonStyle, AnyTaskButtonStyle(style))
	}
}
