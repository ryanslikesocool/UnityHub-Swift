import SwiftUI
import UnityHubCommon
import UnityHubCommonViews

extension Button where
	Label == SwiftUI.Label<Text, Image>
{
	static func createProject() -> some View {
		Button(
			action: { Event.Project.create.send() },
			label: Label.create
		)
		.keyboardShortcut(.new)
		.disabled(true)
	}

	static func locateProject() -> some View {
		Button(
			action: { Event.Project.locate.send(.add) },
			label: Label.locate
		)
		.keyboardShortcut(.open)
	}
}
