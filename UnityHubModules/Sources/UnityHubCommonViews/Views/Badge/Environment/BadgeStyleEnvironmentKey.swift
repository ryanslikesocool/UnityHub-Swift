import SwiftUI

typealias _AnyBadgeStyle = _AnyViewStyle<BadgeStyleConfiguration>

extension EnvironmentValues {
	fileprivate(set) var badgeStyle: _AnyBadgeStyle {
		get { self[__Key_badgeStyle.self] }
		set { self[__Key_badgeStyle.self] = newValue }
	}

	private enum __Key_badgeStyle: EnvironmentKey {
		static let defaultValue = _AnyBadgeStyle(.default)
	}
}

public extension View {
	func badgeStyle(_ style: some BadgeStyle) -> some View {
		environment(\.badgeStyle, _AnyBadgeStyle(style))
	}
}
