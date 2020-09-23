//
//  AppDelegate.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

@main
struct UnityHubApp: App {
    var settings: HubSettings = HubSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 750, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity)
                .environmentObject(settings)
        }
        .windowStyle(TitleBarWindowStyle())
        .windowToolbarStyle(UnifiedWindowToolbarStyle())
        
        Settings {
            SettingsView()
                .frame(width: 320, height: 384)
                .environmentObject(settings)
                .navigationTitle("Settings")
        }
    }
}
