import SwiftUI

/// A wrapper around ``SwiftUI/Link`` that always shows the destination as a tooltip.
/// - Remark: This is maybe a little unnecessary, but I think it's important to be honest with the user about where a link is going.
public struct RealLink<Label: View>: View {
	public typealias LabelProvider = () -> Label

	private let destination: URL
	private let label: LabelProvider

	public init(destination: URL, @ViewBuilder label: @escaping LabelProvider) {
		self.destination = destination
		self.label = label
	}

	public var body: some View {
		Link(destination: destination, label: label)
			.help(destination.description)
	}
}

// MARK: - Init+

public extension RealLink where Label == Text {
	init(_ title: some StringProtocol, destination: URL) {
		self.init(destination: destination, label: { Text(title) })
	}

	init(_ titleKey: LocalizedStringKey, destination: URL) {
		self.init(destination: destination, label: { Text(titleKey) })
	}
}

public extension RealLink where Label == SwiftUI.Label<Text, Image> {
	init(_ title: some StringProtocol, systemImage name: String, destination: URL) {
		self.init(destination: destination, label: { SwiftUI.Label(title, systemImage: name) })
	}

	init(_ titleKey: LocalizedStringKey, systemImage name: String, destination: URL) {
		self.init(destination: destination, label: { SwiftUI.Label(titleKey, systemImage: name) })
	}

	init(_ title: some StringProtocol, image: ImageResource, destination: URL) {
		self.init(destination: destination, label: { SwiftUI.Label(title, image: image) })
	}

	init(_ titleKey: LocalizedStringKey, image: ImageResource, destination: URL) {
		self.init(destination: destination, label: { SwiftUI.Label(titleKey, image: image) })
	}
}
