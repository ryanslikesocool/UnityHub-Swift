import SwiftUI

typealias _AnyUnityEditorVersionLabelStyle = _AnyViewStyle<UnityEditorVersionLabelStyleConfiguration>

extension EnvironmentValues {
	fileprivate(set) var unityEditorVersionLabelStyle: _AnyUnityEditorVersionLabelStyle {
		get { self[__Key_unityEditorVersionLabelStyle.self] }
		set { self[__Key_unityEditorVersionLabelStyle.self] = newValue }
	}

	private enum __Key_unityEditorVersionLabelStyle: EnvironmentKey {
		static let defaultValue = _AnyUnityEditorVersionLabelStyle(.default)
	}
}

public extension View {
	func unityEditorVersionLabelStyle(_ style: some UnityEditorVersionLabelStyle) -> some View {
		environment(\.unityEditorVersionLabelStyle, _AnyUnityEditorVersionLabelStyle(style))
	}
}
