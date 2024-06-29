import SwiftUI

struct _AnyViewStyle<Configuration: ViewStyleConfiguration>: ViewStyle {
	private let _makeBody: (Configuration) -> AnyView

	init(_ style: some ViewStyle<Configuration>) {
		_makeBody = { configuration in
			AnyView(style.makeBody(configuration: configuration))
		}
	}

	func makeBody(configuration: Configuration) -> some View {
		_makeBody(configuration)
	}
}
