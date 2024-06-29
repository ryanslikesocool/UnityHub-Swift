import SwiftUI

public struct Badge<Content: View>: View {
	public typealias ContentProvider = () -> Content
	typealias Configuration = BadgeStyleConfiguration

	@Environment(\.badgeShape) private var badgeShape
	@Environment(\.badgeStyle) private var style

	private let content: ContentProvider
	private let fill: AnyShapeStyle
	private let stroke: AnyShapeStyle

	public init(fill: some ShapeStyle, stroke: some ShapeStyle, @ViewBuilder content: @escaping ContentProvider) {
		self.content = content
		self.fill = AnyShapeStyle(fill)
		self.stroke = AnyShapeStyle(stroke)
	}

	public init(color: Color, @ViewBuilder content: @escaping ContentProvider) {
		self.init(fill: color, stroke: color, content: content)
	}

	public var body: some View {
		style.makeBody(
			configuration: Configuration(
				content: content(),
				shape: badgeShape,
				fill: fill,
				stroke: stroke
			)
		)
	}
}

// MARK: - Init+

public extension Badge where Content == Text {
	init(_ title: some StringProtocol, fill fillColor: Color, stroke strokeColor: Color) {
		self.init(fill: fillColor, stroke: strokeColor, content: { Text(title) })
	}

	init(_ titleKey: LocalizedStringKey, fill fillColor: Color, stroke strokeColor: Color) {
		self.init(fill: fillColor, stroke: strokeColor, content: { Text(titleKey) })
	}

	init(_ title: some StringProtocol, color: Color) {
		self.init(title, fill: color, stroke: color)
	}

	init(_ titleKey: LocalizedStringKey, color: Color) {
		self.init(titleKey, fill: color, stroke: color)
	}
}

public extension Badge where Content == Label<Text, Image> {
	init(_ title: some StringProtocol, systemImage name: String, fill fillColor: Color, stroke strokeColor: Color) {
		self.init(fill: fillColor, stroke: strokeColor, content: { Label(title, systemImage: name) })
	}

	init(_ titleKey: LocalizedStringKey, systemImage name: String, fill fillColor: Color, stroke strokeColor: Color) {
		self.init(fill: fillColor, stroke: strokeColor, content: { Label(titleKey, systemImage: name) })
	}

	init(_ title: some StringProtocol, systemImage name: String, color: Color) {
		self.init(title, systemImage: name, fill: color, stroke: color)
	}

	init(_ titleKey: LocalizedStringKey, systemImage name: String, color: Color) {
		self.init(titleKey, systemImage: name, fill: color, stroke: color)
	}

	init(_ title: some StringProtocol, image: ImageResource, fill fillColor: Color, stroke strokeColor: Color) {
		self.init(fill: fillColor, stroke: strokeColor, content: { Label(title, image: image) })
	}

	init(_ titleKey: LocalizedStringKey, image: ImageResource, fill fillColor: Color, stroke strokeColor: Color) {
		self.init(fill: fillColor, stroke: strokeColor, content: { Label(titleKey, image: image) })
	}

	init(_ title: some StringProtocol, image: ImageResource, color: Color) {
		self.init(title, image: image, fill: color, stroke: color)
	}

	init(_ titleKey: LocalizedStringKey, image: ImageResource, color: Color) {
		self.init(titleKey, image: image, fill: color, stroke: color)
	}
}
