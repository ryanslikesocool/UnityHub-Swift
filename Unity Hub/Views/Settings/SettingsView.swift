//
//  Settingsview.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: HubSettings
    
    var body: some View {
        ScrollView {
            Form {
                Section(header: Text("About").font(.title)) {
                    Text("Unity Hub S v\(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? "0.0")")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    Text("Made with ❤️ by Ryan Boyer")
                        .padding(.bottom, 8)
                }
                ListDividerView()
                Section(header: Text("Locations").font(.title)) {
                    LocationSetting(label: "Unity Hub Location", symbol: "folder", prompt: "Choose Unity Hub.app", isDirectory: false, assignAction: { settings.hubLocation = $0 }, location: settings.hubLocation, isFirst: true)
                    LocationSetting(label: "Default Editor Location", symbol: "folder", prompt: "Choose the default editor location", isDirectory: true, assignAction: { settings.installLocation = $0 }, location: settings.installLocation)
                    LocationSetting(label: "Default Project Location", symbol: "folder", prompt: "Choose the default project location", isDirectory: true, assignAction: { settings.projectLocation = $0 }, location: settings.projectLocation, isLast: true)
                }
                //SettingsLocations(hubLocation: HubSettings.hubLocation, installLocation: HubSettings.installLocation, projectLocation: HubSettings.projectLocation)
                ListDividerView()
                Section(header: Text("Project Panel").font(.title)) {
                    ToggleSetting(label: "Use Emoji", toggle: $settings.useEmoji, isFirst: true)
                    ToggleSetting(label: "Use Pins", toggle: $settings.usePins, isLast: true)
                }
                ListDividerView()
                Section(header: Text("All Panels").font(.title)) {
                    ToggleSetting(label: "Always Show Location", toggle: $settings.alwaysShowLocation, isFirst: true)
                    ToggleSetting(label: "Show Sidebar Count", toggle: $settings.showSidebarCount, isLast: true)
                }
                //SettingsProjectPanel(useEmoji: useEmoji, usePins: usePins, alwaysShowLocation: alwaysShowLocation)
            }
            .padding()
        }
    }
}
