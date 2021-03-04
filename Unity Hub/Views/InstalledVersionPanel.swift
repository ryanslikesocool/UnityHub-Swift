//
//  InstallsTab.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI
import AppKit

struct InstalledVersionPanel: View {
    @EnvironmentObject var settings: HubSettings
    @State private var showInstaller: Bool = false

    var body: some View {
        List(settings.versionsInstalled) { version in
            VStack {
                InstalledVersionButton(version: version, action: {})
                
                if version != settings.versionsInstalled.last ?? UnityVersion.null {
                    ListDividerView()
                }
            }
        }
        .navigationTitle("Installs")
        .onAppear(perform: getAllVersions)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: locateVersion) {
                    Image(systemName: "folder")
                }
            }
            ToolbarItem(placement: .automatic) {
                Button(action: installVersion) {
                    Image(systemName: "plus")
                }
            }
        }.sheet(isPresented: $showInstaller) {
            InstallSheet()
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
