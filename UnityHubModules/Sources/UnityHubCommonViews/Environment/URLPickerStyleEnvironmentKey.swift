import SwiftUI

private enum URLPickerStyleEnvironmentKey: EnvironmentKey {
	static let defaultValue: _AnyURLPickerStyle = _AnyURLPickerStyle(style: .inline)
}

extension EnvironmentValues {
	fileprivate(set) var urlPickerStyle: _AnyURLPickerStyle {
		get { self[URLPickerStyleEnvironmentKey.self] }
		set { self[URLPickerStyleEnvironmentKey.self] = newValue }
	}
}

public extension View {
	func urlPickerStyle(_ style: some URLPickerStyle) -> some View {
		environment(\.urlPickerStyle, _AnyURLPickerStyle(style: style))
	}
}
