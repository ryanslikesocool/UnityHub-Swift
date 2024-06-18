import SwiftUI
import UnityHubStorage

public struct SettingsScene: Scene {
	@Bindable private var appSettings: AppSettings = .shared

	public init() { }

	public var body: some Scene {
		Settings {
			TabView {
				GeneralCategoryTab(model: $appSettings.general)
				ProjectsCategoryTab(model: $appSettings.projects)
			}
			.formStyle(.grouped)
			.fixedSize()
		}
	}
}
