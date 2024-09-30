import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var urlLabelStyle: AnyURLLabelStyle
		= AnyURLLabelStyle(.default)
}

// MARK: - Convenience

public extension View {
	func urlLabelStyle(_ style: some URLLabelStyle) -> some View {
		environment(\.urlLabelStyle, AnyURLLabelStyle(style))
	}
}
