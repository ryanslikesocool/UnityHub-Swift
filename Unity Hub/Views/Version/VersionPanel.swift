//
//  InstallsTab.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI
import AppKit

struct VersionPanel: View {
    @EnvironmentObject var settings: HubSettings
    
    @State private var showInstaller: Bool = false
    
    @State private var showRemovalSheet: Bool = false
    @State private var installToRemove: UnityVersion? = nil

    var body: some View {
        List(settings.hub.versions) { version in
            VStack {
                InstalledVersionButton(version: version, deleteAction: prepareForDeletion)
                
                if version != settings.hub.versions.last ?? UnityVersion.null {
                    Divider()
                }
            }
        }
        .navigationTitle("Installs")
        .onAppear(perform: settings.getAllVersions)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: locateVersion) {
                    Image(systemName: "folder.badge.plus")
                }
            }
            ToolbarItem(placement: .automatic) {
                Button(action: installVersion) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showInstaller) { InstallSheet() }
        .alert(isPresented: $showRemovalSheet) {
            Alert(
                title: Text("Uninstall Unity \(installToRemove!.version)"),
                message: Text("Are you sure you want to uninstall Unity version \(installToRemove!.version)?"),
                primaryButton: .cancel(Text("Cancel")),
                secondaryButton: .destructive(Text("Uninstall")) { deleteItems(install: installToRemove) }
            )
        }
    }
    
    func locateVersion() {
        NSOpenPanel.openFolder { result in
            if case let .success(path) = result {
                if !settings.hub.customInstallLocations.contains(path) {
                    settings.hub.customInstallLocations.append(path)
                }
                
                settings.getAllVersions()
            }
        }
    }
    
    func installVersion() {
        showInstaller.toggle()
    }
        
    func prepareForDeletion(version: UnityVersion) {
        installToRemove = version
        showRemovalSheet.toggle()
    }
    
    func deleteItems(install: UnityVersion?) {
        if let version = install {
            DispatchQueue.global(qos: .background).async {
                let _ = shell("rm -rf \(version.path)")
            }
            settings.hub.versions.removeAll(where: { $0.version == version.version })
            settings.wrap()
        }
        installToRemove = nil
    }
}
