import SwiftUI

public struct URLLabelStyleConfiguration {
	public let label: Label

	@MainActor
	init(
		label: some View
	) {
		self.label = Label(label)
	}
}

// MARK: - Supporting Data

public extension URLLabelStyleConfiguration {
	/// The type-erased label of a ``URLLabel``.
	struct Label: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}
}
