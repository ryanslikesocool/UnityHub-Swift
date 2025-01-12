import SwiftUI

/// ## Topics
/// - ``SwiftUI/LabelStyle/compactSidebar``
struct CompactSidebarLabelStyle: LabelStyle {
	public init() { }

	public func makeBody(configuration: Configuration) -> some View {
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

// MARK: - Convenience

extension LabelStyle where
	Self == CompactSidebarLabelStyle
{
	static var compactSidebar: Self {
		Self()
	}
}
