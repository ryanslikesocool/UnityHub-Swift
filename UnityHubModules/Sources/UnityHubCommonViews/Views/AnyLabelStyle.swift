import SwiftUI

public struct AnyLabelStyle: LabelStyle {
	private let _makeBody: (LabelStyleConfiguration) -> AnyView

	public init(_ style: some LabelStyle) {
		_makeBody = { configuration in
			AnyView(style.makeBody(configuration: configuration))
		}
	}

	public func makeBody(configuration: Configuration) -> some View {
		_makeBody(configuration)
	}
}
