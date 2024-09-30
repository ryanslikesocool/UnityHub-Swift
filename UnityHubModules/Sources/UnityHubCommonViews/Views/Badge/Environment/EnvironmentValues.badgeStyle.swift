import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var badgeStyle: AnyBadgeStyle
		= AnyBadgeStyle(.default)
}

// MARK: - Convenience

public extension View {
	func badgeStyle(_ style: some BadgeStyle) -> some View {
		environment(\.badgeStyle, AnyBadgeStyle(style))
	}
}
