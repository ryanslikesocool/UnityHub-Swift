import SwiftUI

public extension EnvironmentValues {
	fileprivate(set) var badgeShape: AnyShape {
		get { self[__Key_badgeShape.self] }
		set { self[__Key_badgeShape.self] = newValue }
	}

	private enum __Key_badgeShape: EnvironmentKey {
		static let defaultValue: AnyShape = AnyShape(.rect(cornerRadius: 4))
	}
}

public extension View {
	func badgeShape(_ shape: some Shape) -> some View {
		environment(\.badgeShape, AnyShape(shape))
	}
}
