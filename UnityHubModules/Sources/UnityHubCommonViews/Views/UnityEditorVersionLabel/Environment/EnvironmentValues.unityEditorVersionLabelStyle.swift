import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var unityEditorVersionLabelStyle: AnyUnityEditorVersionLabelStyle
		= AnyUnityEditorVersionLabelStyle(.default)
}

// MARK: - Convenience

public extension View {
	func unityEditorVersionLabelStyle(_ style: some UnityEditorVersionLabelStyle) -> some View {
		environment(\.unityEditorVersionLabelStyle, AnyUnityEditorVersionLabelStyle(style))
	}
}
