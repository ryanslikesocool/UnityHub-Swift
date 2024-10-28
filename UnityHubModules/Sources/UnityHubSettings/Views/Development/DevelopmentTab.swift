#if DEBUG
import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubOfficialCLI
import UnityHubStorage

struct DevelopmentTab: SettingsCategoryView {
	static let category: SettingsCategory = .development

	func makeLabel() -> some View {
		SwiftUI.Label("Development", systemImage: Symbol.terminal)
	}

	func makeContent() -> some View {
		Section {
			LogCLIHelpButton()
		}
	}
}
#endif
