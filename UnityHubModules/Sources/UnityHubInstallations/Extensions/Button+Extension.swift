import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension Button where Label == SwiftUI.Label<Text, Image> {
	static func downloadInstallation() -> some View {
		Button(
			action: { Event.Installation.download.send() },
			label: Label.download
		)
		.keyboardShortcut(Constant.Hotkey.new)
	}

	static func locateInstallation() -> some View {
		Button(
			action: { Event.Installation.locate.send(.add) },
			label: Label.locate
		)
		.keyboardShortcut(Constant.Hotkey.open)
	}
}
