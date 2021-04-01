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
                    HStack {
                        Text("Made with ❤️ by")
                        Link("Ryan Boyer", destination: URL(string: "http://ryanjboyer.com")!)
                    }
                    .padding(.top, -6)
                    .padding(.bottom, 8)
                }
                Divider()
                Section(header: Text("Locations").font(.title)) {
                    LocationSetting(label: "Unity Hub Location", symbol: "folder", prompt: "Choose Unity Hub.app", isDirectory: false, assignAction: { settings.hub.hubLocation = $0 }, location: settings.hub.hubLocation, isFirst: true)
                    LocationSetting(label: "Default Editor Location", symbol: "folder", prompt: "Choose the default editor location", isDirectory: true, assignAction: { settings.hub.installLocation = $0 }, location: settings.hub.installLocation)
                    LocationSetting(label: "Default Project Location", symbol: "folder", prompt: "Choose the default project location", isDirectory: true, assignAction: { settings.hub.projectLocation = $0 }, location: settings.hub.projectLocation, isLast: true)
                }
                Divider()
                Section(header: Text("Sidebar").font(.title)) {
                    ToggleSetting(label: "Show Item Count", toggle: $settings.hub.showSidebarCount, isFirst: true, isLast: true)
                }
                Divider()
                Section(header: Text("Project Panel").font(.title)) {
                    ToggleSetting(label: "Use Emoji", toggle: $settings.hub.useEmoji, isFirst: true)
                    ToggleSetting(label: "Use Pins", toggle: $settings.hub.usePins, isLast: true)
                }
                Divider()
                Section(header: Text("All Panels").font(.title)) {
                    ToggleSetting(label: "Show File Location", toggle: $settings.hub.showLocation, isFirst: true)
                    ToggleSetting(label: "Show File Size", toggle: $settings.hub.showFileSize, isLast: true)
                }
            }
            .padding()
        }
    }
}
