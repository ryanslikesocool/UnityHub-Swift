import SwiftUI

typealias _AnyTaskButtonStyle = _AnyViewStyle<TaskButtonStyleConfiguration>

extension EnvironmentValues {
	fileprivate(set) var taskButtonStyle: _AnyTaskButtonStyle {
		get { self[__Key_taskButtonStyle.self] }
		set { self[__Key_taskButtonStyle.self] = newValue }
	}

	private enum __Key_taskButtonStyle: EnvironmentKey {
		static let defaultValue = _AnyTaskButtonStyle(.default)
	}
}

public extension View {
	func taskButtonStyle(_ style: some TaskButtonStyle) -> some View {
		environment(\.taskButtonStyle, _AnyTaskButtonStyle(style))
	}
}
