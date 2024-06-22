import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension Button where Label == SwiftUI.Label<Text, Image> {
	static func createProject() -> some View {
		Button(
			action: { Event.Project.create() },
			label: Label.create
		)
		.keyboardShortcut(Constant.Hotkey.new)
	}

	static func locateProject() -> some View {
		Button(
			action: { Event.Project.locate(.add) },
			label: Label.locate
		)
		.keyboardShortcut(Constant.Hotkey.open)
	}
}
