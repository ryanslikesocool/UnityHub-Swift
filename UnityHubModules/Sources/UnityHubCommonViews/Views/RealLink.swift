import SFSymbolToolbox
import SwiftUI

/// A wrapper around ``SwiftUI/Link`` that always shows the destination as a tooltip.
/// - Remark: This is maybe a little unnecessary, but I think it's important to be upfront with users about where a link is going.
public struct RealLink<Label>: View where
	Label: View
{
	private let destination: URL
	private let label: Label

	public init(
		destination: URL,
		@ViewBuilder label: () -> Label
	) {
		self.destination = destination
		self.label = label()
	}

	public var body: some View {
		Link(destination: destination) {
			label
		}
		.help(destination.description)
	}
}

// MARK: - Convenience

public extension RealLink where
	Label == Text
{
	/// - Parameters:
	///   - title:
	///   - destination:
	init<S>(
		_ title: S,
		destination: URL
	) where
		S: StringProtocol
	{
		self.init(destination: destination, label: { Text(title) })
	}

	/// - Parameters:
	///   - titleKey:
	///   - destination:
	init(
		_ titleKey: LocalizedStringKey,
		destination: URL
	) {
		self.init(destination: destination, label: { Text(titleKey) })
	}
}

public extension RealLink where
	Label == SwiftUI.Label<Text, Image>
{
	/// - Parameters:
	///   - title:
	///   - systemImage:
	///   - destination:
	init<S>(
		_ title: S,
		systemImage: String,
		destination: URL
	) where
		S: StringProtocol
	{
		self.init(destination: destination, label: { SwiftUI.Label(title, systemImage: systemImage) })
	}

	/// - Parameters:
	///   - titleKey:
	///   - systemImage:
	///   - destination:
	init(
		_ titleKey: LocalizedStringKey,
		systemImage: String,
		destination: URL
	) {
		self.init(destination: destination, label: { SwiftUI.Label(titleKey, systemImage: systemImage) })
	}

	/// - Parameters:
	///   - title:
	///   - systemImage:
	///   - destination:
	init<S>(
		_ title: S,
		systemImage: SystemSymbolName,
		destination: URL
	) where
		S: StringProtocol
	{
		self.init(destination: destination, label: { SwiftUI.Label(title, systemImage: systemImage) })
	}

	/// - Parameters:
	///   - titleKey:
	///   - systemImage:
	///   - destination:
	init(
		_ titleKey: LocalizedStringKey,
		systemImage: SystemSymbolName,
		destination: URL
	) {
		self.init(destination: destination, label: { SwiftUI.Label(titleKey, systemImage: systemImage) })
	}

	/// - Parameters:
	///   - title:
	///   - image:
	///   - destination:
	init<S>(
		_ title: S,
		image: ImageResource,
		destination: URL
	) where
		S: StringProtocol
	{
		self.init(destination: destination, label: { SwiftUI.Label(title, image: image) })
	}

	/// - Parameters:
	///   - titleKey:
	///   - image:
	///   - destination:
	init(
		_ titleKey: LocalizedStringKey,
		image: ImageResource,
		destination: URL
	) {
		self.init(destination: destination, label: { SwiftUI.Label(titleKey, image: image) })
	}
}
