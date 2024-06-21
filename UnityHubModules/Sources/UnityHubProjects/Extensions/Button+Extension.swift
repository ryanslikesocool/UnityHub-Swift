import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension Button where Label == SwiftUI.Label<Text, Image> {
	static func createProject() -> some View {
		Button(
			action: { Event.createProject() },
			label: Label.create
		)
		.keyboardShortcut(Constant.Hotkey.new)
	}

	static func locateProject() -> some View {
		Button(
			action: { Event.locateProject(.add) },
			label: Label.locate
		)
		.keyboardShortcut(Constant.Hotkey.open)
	}
}
