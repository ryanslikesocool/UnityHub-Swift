import SwiftUI

typealias _AnyURLPickerStyle = _AnyViewStyle<URLPickerStyleConfiguration>

extension EnvironmentValues {
	fileprivate(set) var urlPickerStyle: _AnyURLPickerStyle {
		get { self[__Key_urlPickerStyle.self] }
		set { self[__Key_urlPickerStyle.self] = newValue }
	}

	private enum __Key_urlPickerStyle: EnvironmentKey {
		static let defaultValue = _AnyURLPickerStyle(.inline)
	}
}

public extension View {
	func urlPickerStyle(_ style: some ViewStyle<URLPickerStyleConfiguration>) -> some View {
		environment(\.urlPickerStyle, _AnyURLPickerStyle(style))
	}
}
