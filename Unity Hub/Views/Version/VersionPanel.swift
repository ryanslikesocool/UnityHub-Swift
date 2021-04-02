//
//  InstallsTab.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import AppKit
import SwiftUI

struct VersionPanel: View {
    @EnvironmentObject var settings: HubSettings
    
    @State private var showInstaller: Bool = false
    
    @State private var showRemovalSheet: Bool = false
    @State private var installToRemove: UnityVersion? = nil

    var body: some View {
        GeometryReader { geometry in
            let sizeBinding = Binding(get: { return geometry.size.width }, set: { _ in })

            List(settings.hub.versions) { version in
                let versionBinding = Binding(get: { return version }, set: { settings.hub.versions.setElement($0, where: { $0.version == version.version }) })

                VStack {
                    VersionButton(viewWidth: sizeBinding, version: versionBinding, deleteAction: prepareForDeletion)
                
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
                        Image(systemName: "folder")
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Button(action: installVersion) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showInstaller) { InstallVersionSheet() }
            .alert(isPresented: $showRemovalSheet) {
                Alert(
                    title: Text("Uninstall Unity \(installToRemove!.version)"),
                    message: Text("Are you sure you want to uninstall Unity version \(installToRemove!.version)?"),
                    primaryButton: .cancel(Text("Cancel")),
                    secondaryButton: .destructive(Text("Uninstall")) { deleteItems(install: installToRemove) }
                )
            }
        }
        .animation(.interactiveSpring())
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
                _ = shell("rm -rf \(version.path)")
            }
            settings.hub.versions.removeAll(where: { $0.version == version.version })
            settings.wrap()
        }
        installToRemove = nil
    }
}
