import SwiftUI

@main
struct UnityHubApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	@StateObject var settings: AppSettings = .shared
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environmentObject(settings)
		}
		.windowStyle(.titleBar)
		.windowToolbarStyle(.unified)
		.commands {
			UniversalCommands()
		}

		Settings {
			SettingsView()
				.frame(width: 384, height: 256)
				.environmentObject(settings)
		}
	}
}
