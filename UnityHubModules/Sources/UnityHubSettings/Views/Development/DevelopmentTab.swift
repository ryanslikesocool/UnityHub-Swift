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
		SwiftUI.Label("Development", systemImage: Constant.Symbol.terminal)
	}

	func makeContent() -> some View {
		Section {
			LabeledContent(content: {
				TaskButton("Log Official CLI Help") {
					do {
						let result = try Shell.officialHub(.headless, .help)
						print(result)
					} catch {
						Logger.module.error("""
						Failed to execute official hub help command:
						\(error.localizedDescription)
						""")
					}
				}
			}, label: EmptyView.init)
		}
	}
}
#endif
