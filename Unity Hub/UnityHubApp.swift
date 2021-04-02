//
//  AppDelegate.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

@main
struct UnityHubApp: App {
    var settings = HubSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 700, maxWidth: .infinity, minHeight: 350, maxHeight: .infinity)
                .environmentObject(settings)
                .onAppear(perform: { settings.getAllVersions() })
        }
        .windowStyle(TitleBarWindowStyle())
        .windowToolbarStyle(UnifiedWindowToolbarStyle())

        Settings {
            SettingsView()
                .frame(width: 320, height: 374)
                .environmentObject(settings)
                .navigationTitle("Settings")
        }
    }
}
