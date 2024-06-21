import SwiftUI
import UnityHubStorage

public struct SettingsScene: Scene {
	public init() { }

	public var body: some Scene {
		Settings {
			TabView {
				GeneralSettingsTab()
				LocationSettingsTab()
			}
			.formStyle(.grouped)
			.fixedSize()
		}
	}
}
