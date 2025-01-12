import SwiftUI

public extension Link where
	Label == SwiftUI.Label<Text, Image>
{
	nonisolated init<S>(
		_ title: S,
		systemImage: String,
		destination: URL
	) where
		S: StringProtocol
	{
		self.init(destination: destination, label: { Label(title, systemImage: systemImage) })
	}

	nonisolated init(
		_ titleKey: LocalizedStringKey,
		systemImage: String,
		destination: URL
	) {
		self.init(destination: destination, label: { Label(titleKey, systemImage: systemImage) })
	}

	nonisolated init<S>(
		_ title: S,
		image: ImageResource,
		destination: URL
	) where
		S: StringProtocol
	{
		self.init(destination: destination, label: { Label(title, image: image) })
	}

	nonisolated init(
		_ titleKey: LocalizedStringKey,
		image: ImageResource,
		destination: URL
	) {
		self.init(destination: destination, label: { Label(titleKey, image: image) })
	}
}
