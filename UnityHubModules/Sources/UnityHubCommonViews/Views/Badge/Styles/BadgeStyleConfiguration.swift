import SwiftUI
import UnityHubStorage

public struct BadgeStyleConfiguration {
	public let content: Content
	public let shape: AnyShape
	public let fill: AnyShapeStyle
	public let stroke: AnyShapeStyle

	@MainActor
	init(
		content: some View,
		shape: AnyShape,
		fill: AnyShapeStyle,
		stroke: AnyShapeStyle
	) {
		self.content = Content(content)
		self.shape = shape
		self.fill = fill
		self.stroke = stroke
	}
}

// MARK: - Supporting Data

public extension BadgeStyleConfiguration {
	/// The type-erased content of a ``Badge``.
	struct Content: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}
}
