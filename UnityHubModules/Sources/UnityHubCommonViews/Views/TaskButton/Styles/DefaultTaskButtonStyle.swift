import SwiftUI

public struct DefaultTaskButtonStyle: TaskButtonStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		HStack(spacing: 4) {
			if configuration.isExecuting {
				ProgressView()
					.controlSize(.small)
			}
			Button(role: configuration.role, action: configuration.action) {
				configuration.label
			}
			.disabled(configuration.isExecuting)
		}
	}
}

// MARK: - Convenience

public extension TaskButtonStyle where
	Self == DefaultTaskButtonStyle
{
	static var `default`: Self {
		Self()
	}
}
