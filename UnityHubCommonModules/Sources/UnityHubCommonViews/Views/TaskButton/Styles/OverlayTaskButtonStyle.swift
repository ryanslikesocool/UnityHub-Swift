import SwiftUI

public struct OverlayTaskButtonStyle: TaskButtonStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
		Button(role: configuration.role, action: configuration.action) {
			configuration.label
				.opacity(configuration.isExecuting ? 0.0 : 1.0)
		}
		.disabled(configuration.isExecuting)
		.overlay {
			if configuration.isExecuting {
				ProgressView()
					.controlSize(.small)
			}
		}
	}
}

public extension TaskButtonStyle where
	Self == OverlayTaskButtonStyle
{
	static var overlay: Self {
		Self()
	}
}
