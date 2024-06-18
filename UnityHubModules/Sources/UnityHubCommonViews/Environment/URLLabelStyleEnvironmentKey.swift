import SwiftUI

private enum URLLabelStyleEnvironmentKey: EnvironmentKey {
	static let defaultValue: _AnyURLLabelStyle = _AnyURLLabelStyle(style: .default)
}

extension EnvironmentValues {
	fileprivate(set) var urlLabelStyle: _AnyURLLabelStyle {
		get { self[URLLabelStyleEnvironmentKey.self] }
		set { self[URLLabelStyleEnvironmentKey.self] = newValue }
	}
}

public extension View {
	func urlLabelStyle(_ style: some URLLabelStyle) -> some View {
		environment(\.urlLabelStyle, _AnyURLLabelStyle(style: style))
	}
}
