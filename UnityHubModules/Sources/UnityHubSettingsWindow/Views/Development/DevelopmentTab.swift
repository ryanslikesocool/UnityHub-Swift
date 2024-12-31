#if DEBUG
import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubCommonViews
import UnityHubOfficialCLI
import UnityHubStorageSettings

struct DevelopmentTab: SettingsCategoryView {
	public static let category: SettingsCategory = .development

	public func makeLabel() -> some View {
		SwiftUI.Label("Development", systemImage: .terminal)
	}

	public func makeContent() -> some View {
		Section {
			LogCLIHelpButton()
		}
	}
}
#endif
