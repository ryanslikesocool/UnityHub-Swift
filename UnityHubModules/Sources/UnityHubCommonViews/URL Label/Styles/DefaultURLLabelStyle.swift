import SwiftUI

public struct DefaultURLLabelStyle: URLLabelStyle {
	public func makeBody(configuration: Configuration) -> some View {
		Text(configuration.text)
			.monospaced()
	}
}

public extension URLLabelStyle where Self == DefaultURLLabelStyle {
	static var `default`: Self { Self() }
}
