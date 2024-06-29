import SwiftUI

public struct DefaultURLLabelStyle: URLLabelStyle {
	public typealias Configuration = URLLabelStyleConfiguration

	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.monospaced()
	}
}

public extension ViewStyle<URLLabelStyleConfiguration> where Self == DefaultURLLabelStyle {
	static var `default`: Self { Self() }
}
