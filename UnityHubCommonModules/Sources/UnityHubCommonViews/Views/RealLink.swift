import SwiftUI

/// A wrapper around ``SwiftUI/Link`` that always shows the destination as a tooltip.
/// - Remark: This is maybe a little unnecessary, but I think it's important to be upfront with users about where a link is going.
public struct RealLink<Label>: View where
	Label: View
{
	public typealias LabelProvider = () -> Label

	private let destination: URL
	private let label: LabelProvider

	public init(
		destination: URL,
		@ViewBuilder label: @escaping LabelProvider
	) {
		self.destination = destination
		self.label = label
	}

	public var body: some View {
		Link(destination: destination, label: label)
			.help(destination.description)
	}
}

// MARK: - Convenience

public extension RealLink where Label == Text {
	init<S>(_ title: S, destination: URL) where
		S: StringProtocol
	{
		self.init(destination: destination, label: { Text(title) })
	}

	init(_ titleKey: LocalizedStringKey, destination: URL) {
		self.init(destination: destination, label: { Text(titleKey) })
	}
}

public extension RealLink where Label == SwiftUI.Label<Text, Image> {
	init<S>(_ title: S, systemImage name: String, destination: URL) where
		S: StringProtocol
	{
		self.init(destination: destination, label: { SwiftUI.Label(title, systemImage: name) })
	}

	init(_ titleKey: LocalizedStringKey, systemImage name: String, destination: URL) {
		self.init(destination: destination, label: { SwiftUI.Label(titleKey, systemImage: name) })
	}

	init<S>(_ title: S, image: ImageResource, destination: URL) where
		S: StringProtocol
	{
		self.init(destination: destination, label: { SwiftUI.Label(title, image: image) })
	}

	init(_ titleKey: LocalizedStringKey, image: ImageResource, destination: URL) {
		self.init(destination: destination, label: { SwiftUI.Label(titleKey, image: image) })
	}
}
