import SwiftUI

public struct AnyUnityEditorVersionLabelStyle: UnityEditorVersionLabelStyle {
	private let _makeBody: @MainActor (Configuration) -> AnyView

	public init(_ style: some UnityEditorVersionLabelStyle) {
		_makeBody = if let style = style as? Self {
			style._makeBody
		} else {
			{ @MainActor configuration in
				AnyView(style.makeBody(configuration: configuration))
			}
		}
	}

	public func makeBody(configuration: Configuration) -> some View {
		_makeBody(configuration)
	}
}
