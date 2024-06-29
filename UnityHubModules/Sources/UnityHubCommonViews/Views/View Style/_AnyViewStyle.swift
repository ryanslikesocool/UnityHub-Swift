import SwiftUI

public struct _AnyViewStyle<Configuration: ViewStyleConfiguration>: ViewStyle {
	private let _makeBody: (Configuration) -> AnyView

	public init(_ style: some ViewStyle<Configuration>) {
		_makeBody = { configuration in
			AnyView(style.makeBody(configuration: configuration))
		}
	}

	public func makeBody(configuration: Configuration) -> some View {
		_makeBody(configuration)
	}
}
