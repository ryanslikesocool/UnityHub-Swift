import SwiftUI

public struct URLLabelStyleConfiguration {
	/// The type-erased label of a ``URLLabel``.
	public struct Label: View {
		init(content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}

	public let label: Label

	init(
		label: some View
	) {
		self.label = Label(content: label)
	}
}
