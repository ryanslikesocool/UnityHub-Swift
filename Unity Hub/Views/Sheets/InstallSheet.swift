//
//  InstallVersionPopup.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import SwiftUI

struct InstallSheet: View {
    @EnvironmentObject var settings: HubSettings
    @Environment(\.presentationMode) var presentationMode
    @State private var tab: String = "Version"
    
    @State private var selectedVersion: UnityVersion = UnityVersion.null
    @State private var selectedModules: [Bool] = []
    
    @State private var availableVersions: [UnityVersion] = []
    @State private var availableModules: [UnityModule] = []

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button("Cancel", action: closeMenu)
                    .buttonStyle(UnityButtonStyle())
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
                    .buttonStyle(UnityButtonStyle())
                    .padding(8)
            }
        }
        .onAppear {
            setupView()
        }
    }
    
    func setupView() {
        tab = "Version"
        availableVersions = getAvailableVersions()
        availableModules = UnityModule.getAvailableModules()
        selectedModules = [Bool](repeating: false, count: availableModules.count)
    }
    
    func getAvailableVersions() -> [UnityVersion] {
        var versions: [UnityVersion] = []

        let command = "\(settings.hubCommandBase) e -r"
        let result = shell(command)
        let results = result.components(separatedBy: "\n")
        
        for result in results {
            let version = result.components(separatedBy: " ").first;
            if version != nil && version != "" && !settings.versionsInstalled.contains(where: { $0.version == version }) {
                versions.append(UnityVersion(version!))
            }
        }
    
        return versions
    }
    
    func closeMenu() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func installSelectedItems() {
        var command = "\(settings.hubCommandBase) i --version \(selectedVersion.version)"
        
        for i in 0 ..< availableModules.count {
            if selectedModules[i] {
                command.append(" -m \(availableModules[i].rawValue)")
            }
        }
        
        let version = selectedVersion.version
        
        DispatchQueue.global(qos: .background).async {
            let string = shell(command)
            
            let index = settings.versionsInstalled.firstIndex(where: { $0.version == version })!
            if string.contains("successfully downloaded") {
                var versionSet = settings.versionsInstalled[index]
                versionSet.installing = false
                settings.versionsInstalled[index] = versionSet
            } else {
                settings.versionsInstalled.remove(at: index)
            }
        }
        
        selectedVersion.installing = true
        selectedVersion.path = "/Applications/Unity/Hub/Editor/\(selectedVersion.version)"
        
        settings.versionsInstalled.append(selectedVersion)
        
        closeMenu()
    }
}
