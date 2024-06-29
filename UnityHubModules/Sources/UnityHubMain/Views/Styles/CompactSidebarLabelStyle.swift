import SwiftUI

struct CompactSidebarLabelStyle: LabelStyle {
	func makeBody(configuration: Configuration) -> some View {
		Spacer()
			.overlay(alignment: .center) {
				configuration.icon
					.font(.largeTitle)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.aspectRatio(1, contentMode: .fit)
			.contentShape(.rect)
	}
}

extension LabelStyle where Self == CompactSidebarLabelStyle {
	static var compactSidebar: Self { Self() }
}
