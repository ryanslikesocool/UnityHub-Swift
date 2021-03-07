//
//  UnityVersionButton.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct InstalledVersionButton: View {
    @EnvironmentObject var settings: HubSettings
    
    @State var version: UnityVersion
    @Binding var alwaysShowLocation: Bool
    var deleteAction: (UnityVersion) -> Void

    @State private var modules: [UnityModule] = []
    @State private var installing: Bool = false
    @State private var showInstallSheet: Bool = false
    @State private var displayFoldout: Bool = false
    
    @State private var showRemovalSheet: Bool = false
    @State private var moduleToRemove: UnityModule? = nil

    var body: some View {
        VStack {
            Button(action: { displayFoldout.toggle() }) {
                mainButton()
            }
            
            if displayFoldout {
                ForEach(modules) { module in
                    InstalledModuleButton(version: version, module: module, deleteAction: prepareForDeletion)
                }
                .onDelete(perform: prepareForDeletion)
            }
        }
        .padding(.vertical, 12)
        .buttonStyle(PlainButtonStyle())
        .onAppear { modules = HubSettings.getInstalledModules(version: version) }
        .sheet(isPresented: $showInstallSheet) { InstallModuleSheet(selectedVersion: version) }
        .alert(isPresented: $showRemovalSheet) {
            Alert(
                title: Text("Uninstall \(moduleToRemove!.getDisplayName()!) module"),
                message: Text("Are you sure you want to uninstall the \(moduleToRemove!.getDisplayName()!) module for Unity \(version.version)?"),
                primaryButton: .cancel(Text("Cancel")),
                secondaryButton: .destructive(Text("Uninstall")) { deleteItems(module: moduleToRemove) }
            )
        }
    }
    
    func mainButton() -> some View {
        HStack {
            if !installing {
                SVGShapes.UnityCube()
                    .frame(width: 16, height: 16)
                    .padding(.leading, 12)
            } else {
                ProgressView()
                    .frame(width: 16, height: 16)
                    .padding(.leading, 12)
            }
            
            versionAndLocation()
            
            if version.isPrerelease() {
                PrereleaseTag(version: version)
                    .padding(4)
            }
            Spacer()
            rightSide()
        }
        .frame(minWidth: 64, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
    }
    
    func versionAndLocation() -> some View {
        Group {
            if !alwaysShowLocation {
                Text(version.version)
                    .font(.system(size: 12, weight: .semibold))
                    .help(version.path)
            } else {
                VStack(alignment: .leading) {
                    Text(version.version)
                        .font(.system(size: 12, weight: .semibold))
                    Text(version.path)
                        .font(.system(size: 11, weight: .regular))
                        .opacity(0.5)
                }
            }
        }
    }
    
    func rightSide() -> some View {
        HStack {
            ForEach(modules) { item in
                if let icon = item.getIcon() {
                    icon
                        .frame(width: 16, height: 16)
                        .help(item.getDisplayName() ?? "")
                }
            }
            Menu {
                Button("Install Additional Modules", action: installModuleSheet)
                Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: version.path) })
                Button("Uninstall Version", action: { deleteAction(version) })
            } label: {}
            .labelsHidden()
            .menuStyle(BorderlessButtonMenuStyle())
            .frame(width: 16)
            .padding(.trailing, 16)
        }
    }
    
    func installModuleSheet() {
        showInstallSheet.toggle()
    }
    
    func prepareForDeletion(offsets: IndexSet) {
        prepareForDeletion(module: modules[offsets.first!])
    }
    
    func prepareForDeletion(module: UnityModule) {
        moduleToRemove = module
        showRemovalSheet.toggle()
    }
    
    func deleteItems(module: UnityModule?) {
        if let m = module {
            HubSettings.removeModule(version: version, module: m)
            modules.removeAll { $0.id == m.id }
        }
        moduleToRemove = nil
    }
}
