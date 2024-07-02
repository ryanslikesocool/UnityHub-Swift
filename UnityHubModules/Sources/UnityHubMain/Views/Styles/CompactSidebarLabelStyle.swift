import SwiftUI

struct CompactSidebarLabelStyle: LabelStyle {
	func makeBody(configuration: Configuration) -> some View {
		HStack {
			Spacer()
			configuration.icon
			Spacer()
		}
		.font(.largeTitle)
		.frame(height: 48)
		.aspectRatio(1, contentMode: .fill)
		.contentShape(.rect)
	}
}

extension LabelStyle where Self == CompactSidebarLabelStyle {
	static var compactSidebar: Self { Self() }
}
