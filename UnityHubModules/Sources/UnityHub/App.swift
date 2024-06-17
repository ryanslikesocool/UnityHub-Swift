import SwiftUI
import UnityHubAbout
import UnityHubLauncher
import UnityHubSettings

@main
struct App: SwiftUI.App {
	var body: some Scene {
		LauncherScene()
		AboutScene()
		SettingsScene()
	}
}
