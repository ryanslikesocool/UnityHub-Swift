//
//  InstallsTab.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI
import AppKit

struct InstallsTab: View {
    @EnvironmentObject var settings: HubSettings
    @State private var showInstaller: Bool = false

    var body: some View {
        List {
            ForEach(settings.versionsInstalled, id: \.self.0) { version in
                UnityVersionButton(path: version.0, version: version.1, action: {})
            }
        }
        .navigationTitle("Installs")
        .onAppear(perform: getAllVersions)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: locateVersion) {
                    Image(systemName: "magnifyingglass")
                }
            }
            ToolbarItem(placement: .automatic) {
                Button(action: installVersion) {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: $showInstaller) {
            InstallVersionSheet()
        }
    }
    
    func getAllVersions() {
        HubSettings.getAllVersions(settings: settings)
    }
    
    func locateVersion() {
        NSOpenPanel.openFolder { result in
            if case let .success(path) = result {
                if !HubSettings.customInstallPaths.contains(path) {
                    HubSettings.customInstallPaths.append(path)
                }
                
                getAllVersions()
            }
        }
    }
    
    func installVersion() {
        showInstaller.toggle()
    }
}
