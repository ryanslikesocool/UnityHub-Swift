import SwiftUI
import UnityHubSettingsStorage

public struct SettingsScene: Scene {
	@Bindable private var appSettings: AppSettings = .shared

	public init() { }

	public var body: some Scene {
		Settings {
			TabView {
				GeneralCategoryTab(model: $appSettings.general)
			}
			.formStyle(.grouped)
			.fixedSize()
		}
	}
}
