import SwiftUI

typealias _AnyURLLabelStyle = _AnyViewStyle<URLLabelStyleConfiguration>

private enum URLLabelStyleEnvironmentKey: EnvironmentKey {
	static let defaultValue = _AnyURLLabelStyle(.default)
}

extension EnvironmentValues {
	fileprivate(set) var urlLabelStyle: _AnyURLLabelStyle {
		get { self[URLLabelStyleEnvironmentKey.self] }
		set { self[URLLabelStyleEnvironmentKey.self] = newValue }
	}
}

public extension View {
	func urlLabelStyle(_ style: some URLLabelStyle) -> some View {
		environment(\.urlLabelStyle, _AnyURLLabelStyle(style))
	}
}
