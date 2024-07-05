import SwiftUI

typealias _AnyURLLabelStyle = _AnyViewStyle<URLLabelStyleConfiguration>

extension EnvironmentValues {
	fileprivate(set) var urlLabelStyle: _AnyURLLabelStyle {
		get { self[__Key_urlLabelStyle.self] }
		set { self[__Key_urlLabelStyle.self] = newValue }
	}

	private enum __Key_urlLabelStyle: EnvironmentKey {
		static let defaultValue = _AnyURLLabelStyle(.default)
	}
}

public extension View {
	func urlLabelStyle(_ style: some URLLabelStyle) -> some View {
		environment(\.urlLabelStyle, _AnyURLLabelStyle(style))
	}
}
