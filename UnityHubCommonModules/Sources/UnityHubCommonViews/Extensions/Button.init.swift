import SwiftUI

public extension Button where
	Label == SwiftUI.Label<Text, Image>
{
	init(_ title: some StringProtocol, image name: String, action: @escaping () -> Void) {
		self.init(action: action, label: { Label(title, image: name) })
	}

	init(_ title: some StringProtocol, image name: String, role: ButtonRole?, action: @escaping () -> Void) {
		self.init(role: role, action: action, label: { Label(title, image: name) })
	}

	init(_ titleKey: LocalizedStringKey, image name: String, action: @escaping () -> Void) {
		self.init(action: action, label: { Label(titleKey, image: name) })
	}

	init(_ titleKey: LocalizedStringKey, image name: String, role: ButtonRole?, action: @escaping () -> Void) {
		self.init(role: role, action: action, label: { Label(titleKey, image: name) })
	}
}