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
                    Text("Unity Hub v\(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? "0.0")")
                        .font(.system(.body, design: .monospaced))
                        .bold()
                    Text("Made with ❤️ by Ryan Boyer")
                        .padding(.bottom, 8)
                }
                ListDividerView()
                Section(header: Text("Locations").font(.title)) {
                    HStack {
                        Button(action: { pickFile("Choose Unity Hub.app", isDirectory: false, assignAction: { HubSettings.hubLocation = $0 }) }) {
                            Image(systemName: "folder")
                        }
                        Text("Hub Location")
                        Spacer()
                    }
                    .padding(.top, -4)
                    Text(HubSettings.hubLocation)
                        .font(.system(size: 11, weight: .semibold, design: .monospaced))
                        .opacity(0.75)
                        .padding(.top, -4)

                    HStack {
                        Button(action: { pickFile("Choose the default editor location", isDirectory: true, assignAction: { HubSettings.installLocation = $0 }) }) {
                            Image(systemName: "folder")
                        }
                        Text("Default Editor Location")
                        Spacer()
                    }
                    Text(HubSettings.installLocation)
                        .font(.system(size: 11, weight: .semibold, design: .monospaced))
                        .opacity(0.75)
                        .padding(.top, -4)

                    HStack {
                        Button(action: { pickFile("Choose the default project location", isDirectory: true, assignAction: { HubSettings.projectLocation = $0 }) }) {
                            Image(systemName: "folder")
                        }
                        Text("Default Project Location")
                        Spacer()
                    }
                    Text(HubSettings.projectLocation)
                        .font(.system(size: 11, weight: .semibold, design: .monospaced))
                        .opacity(0.75)
                        .padding(.top, -4)
                        .padding(.bottom, 8)
                }
                ListDividerView()
                Section(header: Text("Project Panel").font(.title)) {
                    HStack {
                        Toggle("", isOn: useEmoji)
                            .toggleStyle(SwitchToggleStyle())
                            .labelsHidden()
                        Text("Use Emoji")
                    }
                    .padding(.top, -4)
                    HStack {
                        Toggle("", isOn: usePins)
                            .toggleStyle(SwitchToggleStyle())
                            .labelsHidden()
                        Text("Use Pins")
                    }
                    HStack {
                        Toggle("", isOn: alwaysShowLocation)
                            .toggleStyle(SwitchToggleStyle())
                            .labelsHidden()
                        Text("Always Show Location")
                    }
                }
            }
            .padding()
        }
    }
    
    func pickFile(_ title: String, isDirectory: Bool, assignAction: (String) -> Void) {
        let dialog = NSOpenPanel();

        dialog.title = title
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.allowsMultipleSelection = false
        dialog.canChooseDirectories = isDirectory

        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file

            if (result != nil) {
                let path: String = result!.path
                assignAction(path)
            }
        } else {
            return
        }
    }
}
