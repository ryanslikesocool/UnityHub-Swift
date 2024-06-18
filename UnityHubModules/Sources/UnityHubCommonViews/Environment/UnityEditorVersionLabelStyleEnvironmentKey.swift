import SwiftUI

private enum UnityEditorVersionLabelStyleEnvironmentKey: EnvironmentKey {
	static let defaultValue: _AnyUnityEditorVersionLabelStyle = _AnyUnityEditorVersionLabelStyle(style: .default)
}

extension EnvironmentValues {
	fileprivate(set) var unityEditorVersionLabelStyle: _AnyUnityEditorVersionLabelStyle {
		get { self[UnityEditorVersionLabelStyleEnvironmentKey.self] }
		set { self[UnityEditorVersionLabelStyleEnvironmentKey.self] = newValue }
	}
}

public extension View {
	func unityEditorVersionLabelStyle(_ style: some UnityEditorVersionLabelStyle) -> some View {
		environment(\.unityEditorVersionLabelStyle, _AnyUnityEditorVersionLabelStyle(style: style))
	}
}
