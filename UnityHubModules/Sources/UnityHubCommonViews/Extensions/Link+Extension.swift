import SwiftUI

public extension Link where Label == SwiftUI.Label<Text, Image> {
	init(_ title: some StringProtocol, systemImage name: String, destination: URL) {
		self.init(destination: destination) { Label(title, systemImage: name) }
	}

	init(_ titleKey: LocalizedStringKey, systemImage name: String, destination: URL) {
		self.init(destination: destination) { Label(titleKey, systemImage: name) }
	}

	init(_ title: some StringProtocol, image: ImageResource, destination: URL) {
		self.init(destination: destination) { Label(title, image: image) }
	}

	init(_ titleKey: LocalizedStringKey, image: ImageResource, destination: URL) {
		self.init(destination: destination) { Label(titleKey, image: image) }
	}
}
