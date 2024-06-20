import SwiftUI

struct _AnyURLPickerStyle: URLPickerStyle {
	private var _makeBody: (Configuration) -> AnyView

	init(style: some URLPickerStyle) {
		_makeBody = { configuration in
			AnyView(style.makeBody(configuration: configuration))
		}
	}

	func makeBody(configuration: Configuration) -> some View {
		_makeBody(configuration)
	}
}
