import SwiftUI

struct _AnyUnityEditorVersionLabelStyle: UnityEditorVersionLabelStyle {
	private var _makeBody: (Configuration) -> AnyView

	init(style: some UnityEditorVersionLabelStyle) {
		_makeBody = { configuration in
			AnyView(style.makeBody(configuration: configuration))
		}
	}

	func makeBody(configuration: Configuration) -> some View {
		_makeBody(configuration)
	}
}
