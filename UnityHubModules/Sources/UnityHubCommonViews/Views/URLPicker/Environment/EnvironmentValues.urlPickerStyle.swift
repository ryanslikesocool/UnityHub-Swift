import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var urlPickerStyle: AnyURLPickerStyle
		= AnyURLPickerStyle(.inline)
}

// MARK: - Convenience

public extension View {
	func urlPickerStyle(_ style: some URLPickerStyle) -> some View {
		environment(\.urlPickerStyle, AnyURLPickerStyle(style))
	}
}
