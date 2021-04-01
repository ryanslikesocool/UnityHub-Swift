//
//  InstallVersionPopup.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import SwiftUI

struct InstallVersionSheet: View {
    @EnvironmentObject var settings: HubSettings
    @Environment(\.presentationMode) var presentationMode
    @State private var tab: String = "Version"
    
    @State private var selectedVersion = UnityVersion.null
    @State private var selectedModules: [UnityModule: Bool] = [:]
    
    @State private var availableVersions: [UnityVersion] = []
    @State private var availableModules: [UnityModule] = []

    var body: some View {
        Group {
            if availableVersions.count == 0 {
                ProgressView("Loading")
                    .padding()
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Button("Cancel", action: closeMenu)
                            .padding(8)
                        Spacer()
                    }
                    TabView(selection: $tab) {
                        VersionSheet(selectedVersion: $selectedVersion, availableVersions: $availableVersions)
                        ModuleSheet(selectedModules: $selectedModules, availableModules: $availableModules)
                    }
                    .padding(.horizontal)
                    HStack {
                        Spacer()
                        Button("Install", action: installSelectedItems)
                            .disabled(selectedVersion == UnityVersion.null)
                            .padding(8)
                    }
                }
            }
        }
        .onAppear {
            tab = "Version"
            getAvailableVersions()
            availableModules = UnityModule.getAvailableModules()
            for module in availableModules {
                selectedModules[module] = false
            }
        }
    }
    
    func getAvailableVersions() {
        DispatchQueue.global(qos: .background).async {
            var versions: [UnityVersion] = []

            let command = "\(settings.hubCommandBase) e -r"
            let result = shell(command)
            let results = result.components(separatedBy: "\n")
            
            for result in results {
                let version = result.components(separatedBy: " ").first
                if let version = version, version != "", !settings.hub.versions.contains(where: { $0.version == version }) {
                    versions.append(UnityVersion(version))
                }
            }

            DispatchQueue.main.async {
                availableVersions = versions
            }
        }
    }
    
    func closeMenu() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func installSelectedItems() {
        var command = "\(settings.hubCommandBase) im --version \(selectedVersion.version)"
        
        for module in availableModules {
            if selectedModules[module] ?? false {
                command.append(" -m \(module.rawValue)")
            }
        }
        
        command.append(" --cm")
        
        let version = selectedVersion.version
        
        DispatchQueue.global(qos: .background).async {
            let string = shell(command)
            
            DispatchQueue.main.async {
                let index = settings.hub.versions.firstIndex(where: { $0.version == version })!
                if string.contains("successfully downloaded") {
                    var versionSet = settings.hub.versions[index]
                    versionSet.installing = false
                    settings.hub.versions[index] = versionSet
                } else {
                    settings.hub.versions.remove(at: index)
                }
                settings.wrap()
            }
        }
        
        selectedVersion.installing = true
        selectedVersion.path = "/Applications/Unity/Hub/Editor/\(selectedVersion.version)"
        
        settings.hub.versions.append(selectedVersion)
        settings.wrap()
        
        closeMenu()
    }
}
