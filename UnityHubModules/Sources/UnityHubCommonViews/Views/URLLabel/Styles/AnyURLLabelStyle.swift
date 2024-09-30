import SwiftUI

public struct AnyURLLabelStyle: URLLabelStyle {
	private let _makeBody: @MainActor (Configuration) -> AnyView

	public init(_ style: some URLLabelStyle) {
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
