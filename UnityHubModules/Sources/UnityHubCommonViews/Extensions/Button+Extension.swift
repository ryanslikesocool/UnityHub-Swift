import SwiftUI
import UnityHubCommon

public extension Button where Label == SwiftUI.Label<Text, Image> {
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

// MARK: - Presets

public extension Button where Label == SwiftUI.Label<Text, Image> {
	static func info(action: @escaping () -> Void) -> some View {
		Button(action: action, label: Label.info)
			.keyboardShortcut(Constant.Hotkey.info)
	}

	static func showInFinder(destination: URL) -> Self {
		Button(action: destination.showInFinder, label: Label.showInFinder)
	}
}
