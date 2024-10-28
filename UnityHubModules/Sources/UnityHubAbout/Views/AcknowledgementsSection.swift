import SwiftUI

struct AcknowledgementsSection: View {
	public init() { }

	public var body: some View {
		VStack(spacing: AboutScene.groupSpacing) {
			ContributorsButton()
			AcknowledgementsButton()
		}
		.buttonStyle(.automatic.expandedLabel(axes: .horizontal))
		.controlSize(.large)
	}
}