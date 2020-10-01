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
    @State private var selectedVersion: UnityVersion = UnityVersion.null
    @State private var selectedModules: [Bool] = []
    @State private var availableVersions: [UnityVersion] = []
    @State private var availableModules: [UnityModule] = []

    var body: some View {
        VStack(alignment: .leading) {
            Button("Cancel", action: closeMenu)
            TabView(selection: $tab) {
                Form {
                    Text("Select a version of Unity")
                        .font(.system(size: 14, weight: .bold))
                    Picker("", selection: $selectedVersion) {
                        ForEach(availableVersions, id: \.self) { version in
                            HStack {
                                Text(version.version)
                                if version.isAlpha() || version.isBeta() {
                                    PrereleaseTag(version: version)
                                }
                            }
                            .tag(version)
                            .frame(height: 24)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(RadioGroupPickerStyle())
                }
                .tabItem { Text("Version") }
                .tag("Version")
                .padding()
                
                Form {
                    Text("Select build targets")
                        .font(.system(size: 14, weight: .bold))
                    ForEach(0 ..< availableModules.count, id: \.self) { i in
                        Toggle(availableModules[i].getDisplayName()!, isOn: $selectedModules[i])
                    }
                }
                .tabItem { Text("Modules") }
                .tag("Modules")
                .padding()
            }
            
            HStack {
                Spacer()
                Button("Install", action: installSelectedItems)
                    .disabled(selectedVersion == UnityVersion.null)
            }
        }
        .foregroundColor(Color(.textColor))
        .padding()
        .foregroundColor(Color(.windowBackgroundColor))
        .frame(width: 256, height: 390)
        .onAppear {
            setupView()
        }
    }
        
    func setupView() {
        tab = "Version"
        availableVersions = getAvailableVersions()
        availableModules = getAvailableModules()
        selectedModules = [Bool](repeating: false, count: availableModules.count)
    }
    
    func getAvailableVersions() -> [UnityVersion] {
        var versions: [UnityVersion] = []

        let command = "\(HubSettings.hubCommandBase) e -r"
        let result = shell(command)
        let results = result.components(separatedBy: "\n")
        
        for result in results {
            let version = result.components(separatedBy: " ").first;
            if version != nil && version != "" && !settings.versionsInstalled.contains(where: { $0.1.version == version }) {
                versions.append(UnityVersion(version!))
            }
        }
    
        return versions
    }
    
    func getAvailableModules() -> [UnityModule] {
        return [
            .android,
            .iOS,
            .tvOS,
            .linuxMono,
            .linuxIL2CPP,
            .macOSIL2CPP,
            .webgl,
            .windowsMono,
            .lumin
        ]
    }
    
    func closeMenu() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func installSelectedItems() {
        let command = "\(HubSettings.hubCommandBase) i --version \(selectedVersion.version)"
        DispatchQueue.global(qos: .background).async {
            let _ = shell(command)
        }
    }
}
