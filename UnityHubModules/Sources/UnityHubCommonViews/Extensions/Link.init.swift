import SFSymbolToolbox
import SwiftUI

public extension Link where
	Label == SwiftUI.Label<Text, Image>
{
	/// - Parameters:
	///   - title:
	///   - systemImage:
	///   - destination:
	nonisolated init<S>(
		_ title: S,
		systemImage: String,
		destination: URL
	) where
		S: StringProtocol
	{
		self.init(destination: destination, label: { Label(title, systemImage: systemImage) })
	}

	/// - Parameters:
	///   - titleKey:
	///   - systemImage:
	///   - destination:
	nonisolated init(
		_ titleKey: LocalizedStringKey,
		systemImage: String,
		destination: URL
	) {
		self.init(destination: destination, label: { Label(titleKey, systemImage: systemImage) })
	}

	/// - Parameters:
	///   - title:
	///   - systemImage:
	///   - destination:
	nonisolated init<S>(
		_ title: S,
		systemImage: SystemSymbolName,
		destination: URL
	) where
		S: StringProtocol
	{
		self.init(title, systemImage: systemImage.rawValue, destination: destination)
	}

	/// - Parameters:
	///   - titleKey:
	///   - systemImage:
	///   - destination:
	nonisolated init(
		_ titleKey: LocalizedStringKey,
		systemImage: SystemSymbolName,
		destination: URL
	) {
		self.init(titleKey, systemImage: systemImage.rawValue, destination: destination)
	}

	/// - Parameters:
	///   - title:
	///   - image:
	///   - destination:
	nonisolated init<S>(
		_ title: S,
		image: ImageResource,
		destination: URL
	) where
		S: StringProtocol
	{
		self.init(destination: destination, label: { Label(title, image: image) })
	}

	/// - Parameters:
	///   - titleKey:
	///   - image:
	///   - destination:
	nonisolated init(
		_ titleKey: LocalizedStringKey,
		image: ImageResource,
		destination: URL
	) {
		self.init(destination: destination, label: { Label(titleKey, image: image) })
	}
}
