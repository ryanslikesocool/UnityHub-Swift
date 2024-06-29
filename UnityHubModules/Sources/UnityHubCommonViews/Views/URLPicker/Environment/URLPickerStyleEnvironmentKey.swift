import SwiftUI

typealias _AnyURLPickerStyle = _AnyViewStyle<URLPickerStyleConfiguration>

private enum URLPickerStyleEnvironmentKey: EnvironmentKey {
	static let defaultValue = _AnyURLPickerStyle(.inline)
}

extension EnvironmentValues {
	fileprivate(set) var urlPickerStyle: _AnyURLPickerStyle {
		get { self[URLPickerStyleEnvironmentKey.self] }
		set { self[URLPickerStyleEnvironmentKey.self] = newValue }
	}
}

public extension View {
	func urlPickerStyle(_ style: some ViewStyle<URLPickerStyleConfiguration>) -> some View {
		environment(\.urlPickerStyle, _AnyURLPickerStyle(style))
	}
}
