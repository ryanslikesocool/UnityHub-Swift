import SwiftUI

@main
struct UnityHubApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	@StateObject var settings: AppSettings = .shared
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.frame(width: 1000, height: 600)
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
