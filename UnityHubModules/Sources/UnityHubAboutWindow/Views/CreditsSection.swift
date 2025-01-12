import SwiftUI

struct CreditsSection: View {
	public init() { }

	public var body: some View {
		VStack(spacing: Self.spacing) {
			ContributorsButton()
			AcknowledgementsButton()
		}
		.buttonStyle(Self.buttonStyle)
		.controlSize(Self.controlSize)
		.disabled(true)
	}
}

// MARK: - Constants

private extension CreditsSection {
	static var spacing: CGFloat { AboutScene.groupSpacing }

	static var buttonStyle: some PrimitiveButtonStyle { .automatic.expandingLabel(.horizontal) }
	static let controlSize: ControlSize = .large
}
