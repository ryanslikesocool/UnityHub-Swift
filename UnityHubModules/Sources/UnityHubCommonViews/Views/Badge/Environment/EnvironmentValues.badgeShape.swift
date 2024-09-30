import SwiftUI

public extension EnvironmentValues {
	@Entry
	fileprivate(set) var badgeShape: AnyShape
		= AnyShape(.rect(cornerRadius: 4))
}

// MARK: - Convenience

public extension View {
	func badgeShape(_ shape: some Shape) -> some View {
		environment(\.badgeShape, AnyShape(shape))
	}
}
