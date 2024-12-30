import SwiftUI

public struct DefaultURLLabelStyle: URLLabelStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.monospaced()
	}
}

// MARK: - Convenienice

public extension URLLabelStyle where
	Self == DefaultURLLabelStyle
{
	static var `default`: Self {
		Self()
	}
}
