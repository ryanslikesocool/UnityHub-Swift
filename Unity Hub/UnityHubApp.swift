//
//  AppDelegate.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

@main
struct UnityHubApp: App {
	var settings = AppState()

	var body: some Scene {
		WindowGroup {
			ContentView()
				.frame(minWidth: 750, minHeight: 400)
				.environmentObject(settings)
				.onAppear(perform: { settings.getAllVersions() })
		}
		.windowStyle(TitleBarWindowStyle())
		.windowToolbarStyle(UnifiedWindowToolbarStyle())
		.commands {
			AppInfoCommands()
		}

		Settings {
			SettingsView()
				.frame(width: 320, height: 374)
				.environmentObject(settings)
				.navigationTitle("Settings")
		}
	}
}
