import SwiftUI

public struct Badge<Content>: View where
	Content: View
{
	typealias Configuration = BadgeStyleConfiguration

	@Environment(\.badgeShape) private var badgeShape
	@Environment(\.badgeStyle) private var style

	private let content: Content
	private let fill: AnyShapeStyle
	private let stroke: AnyShapeStyle

	public init(
		fill: some ShapeStyle,
		stroke: some ShapeStyle,
		@ViewBuilder content: () -> Content
	) {
		self.content = content()
		self.fill = AnyShapeStyle(fill)
		self.stroke = AnyShapeStyle(stroke)
	}

	public init(
		color: Color,
		@ViewBuilder content: () -> Content
	) {
		self.init(fill: color, stroke: color, content: content)
	}

	public var body: some View {
		let configuration = Configuration(
			content: content,
			shape: badgeShape,
			fill: fill,
			stroke: stroke
		)

		style.makeBody(configuration: configuration)
	}
}

// MARK: - Convenience

public extension Badge where
	Content == Text
{
	init<S>(
		_ title: S,
		fill fillColor: Color,
		stroke strokeColor: Color
	) where
		S: StringProtocol
	{
		self.init(fill: fillColor, stroke: strokeColor, content: { Text(title) })
	}

	init(
		_ titleKey: LocalizedStringKey,
		fill fillColor: Color,
		stroke strokeColor: Color
	) {
		self.init(fill: fillColor, stroke: strokeColor, content: { Text(titleKey) })
	}

	init<S>(
		_ title: S,
		color: Color
	) where
		S: StringProtocol
	{
		self.init(
			title,
			fill: color,
			stroke: color
		)
	}

	init(
		_ titleKey: LocalizedStringKey,
		color: Color
	) {
		self.init(titleKey, fill: color, stroke: color)
	}
}

public extension Badge where
	Content == Label<Text, Image>
{
	init<S>(
		_ title: S,
		systemImage name: String,
		fill fillColor: Color,
		stroke strokeColor: Color
	) where
		S: StringProtocol
	{
		self.init(fill: fillColor, stroke: strokeColor, content: { Label(title, systemImage: name) })
	}

	init(
		_ titleKey: LocalizedStringKey,
		systemImage name: String,
		fill fillColor: Color,
		stroke strokeColor: Color
	) {
		self.init(fill: fillColor, stroke: strokeColor, content: { Label(titleKey, systemImage: name) })
	}

	init<S>(
		_ title: S,
		systemImage name: String,
		color: Color
	) where
		S: StringProtocol
	{
		self.init(title, systemImage: name, fill: color, stroke: color)
	}

	init(
		_ titleKey: LocalizedStringKey,
		systemImage name: String,
		color: Color
	) {
		self.init(titleKey, systemImage: name, fill: color, stroke: color)
	}

	init<S>(
		_ title: S,
		image: ImageResource,
		fill fillColor: Color,
		stroke strokeColor: Color
	) where
		S: StringProtocol
	{
		self.init(fill: fillColor, stroke: strokeColor, content: { Label(title, image: image) })
	}

	init(
		_ titleKey: LocalizedStringKey,
		image: ImageResource,
		fill fillColor: Color,
		stroke strokeColor: Color
	) {
		self.init(fill: fillColor, stroke: strokeColor, content: { Label(titleKey, image: image) })
	}

	init<S>(
		_ title: S,
		image: ImageResource,
		color: Color
	) where
		S: StringProtocol
	{
		self.init(title, image: image, fill: color, stroke: color)
	}

	init(
		_ titleKey: LocalizedStringKey,
		image: ImageResource,
		color: Color
	) {
		self.init(titleKey, image: image, fill: color, stroke: color)
	}
}
