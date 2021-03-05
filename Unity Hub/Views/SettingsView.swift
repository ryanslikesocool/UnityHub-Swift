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
        let useEmoji = Binding(
            get: { HubSettings.useEmoji },
            set: { HubSettings.useEmoji = $0 }
        )
        let usePins = Binding(
            get: { HubSettings.usePins },
            set: { HubSettings.usePins = $0 }
        )
        let alwaysShowLocation = Binding(
            get: { HubSettings.alwaysShowLocation },
            set: { HubSettings.alwaysShowLocation = $0 }
        )
        
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
                SettingsLocations(hubLocation: HubSettings.hubLocation, installLocation: HubSettings.installLocation, projectLocation: HubSettings.projectLocation)
                ListDividerView()
                SettingsProjectPanel(useEmoji: useEmoji, usePins: usePins, alwaysShowLocation: alwaysShowLocation)
            }
            .padding()
        }
    }
}
