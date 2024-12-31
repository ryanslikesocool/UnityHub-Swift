import SwiftUI

struct AcknowledgementsSection: View {
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

private extension AcknowledgementsSection {
	static var spacing: CGFloat { AboutScene.groupSpacing }

	static var buttonStyle: some PrimitiveButtonStyle { .automatic.expandedLabel(axes: .horizontal) }
	static let controlSize: ControlSize = .large
}