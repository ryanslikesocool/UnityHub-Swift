#if DEBUG
import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubOfficialCLI
import UnityHubStorageSettings

struct DevelopmentTab: SettingsCategoryView {
	static let category: SettingsCategory = .development

	func makeLabel() -> some View {
		SwiftUI.Label("Development", systemImage: .terminal)
	}

	func makeContent() -> some View {
		Section {
			LogCLIHelpButton()
		}
	}
}
#endif
