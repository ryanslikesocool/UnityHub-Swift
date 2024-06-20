import SwiftUI
import UnityHubStorage

public struct SettingsScene: Scene {
	@Bindable private var appSettings: AppSettings = .shared

	public init() { }

	public var body: some Scene {
		Settings {
			TabView {
				GeneralTab(model: $appSettings.general)
				ProjectsTab(model: $appSettings.projects)
				InstallationsTab(model: $appSettings.installations)
			}
			.formStyle(.grouped)
			.fixedSize()
		}
	}
}
