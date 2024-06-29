import SwiftUI
import UnityHubStorage

public struct BadgeStyleConfiguration: ViewStyleConfiguration {
	/// The type-erased content of a ``Badge``.
	public struct Content: View {
		init(content: some View) {
			body = AnyView(content)
		}

		public var body: AnyView
	}

	public let content: Content
	public let shape: AnyShape
	public let fill: AnyShapeStyle
	public let stroke: AnyShapeStyle

	init(
		content: some View,
		shape: AnyShape,
		fill: AnyShapeStyle,
		stroke: AnyShapeStyle
	) {
		self.content = Content(content: content)
		self.shape = shape
		self.fill = fill
		self.stroke = stroke
	}
}
