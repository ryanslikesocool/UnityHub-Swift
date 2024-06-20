import SwiftUI

struct _AnyURLLabelStyle: URLLabelStyle {
	private var _makeBody: (Configuration) -> AnyView

	init(style: some URLLabelStyle) {
		_makeBody = { configuration in
			AnyView(style.makeBody(configuration: configuration))
		}
	}

	func makeBody(configuration: Configuration) -> some View {
		_makeBody(configuration)
	}
}
