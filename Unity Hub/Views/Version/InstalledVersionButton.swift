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
    let deleteAction: (UnityVersion) -> Void

    @State private var modules: [UnityModule] = []
    @State private var installing: Bool = false
    @State private var showInstallSheet: Bool = false
    @State private var displayFoldout: Bool = false
    
    @State private var showRemovalSheet: Bool = false
    @State private var moduleToRemove: UnityModule? = nil
    
    private var leadingSwipeActions: [Slot] {
        get { return displayFoldout ? [] : [Slot(
            image: { Image(systemName: "star.fill").frame(width: .swipeActionIconSize, height: .swipeActionIconSize).embedInAnyView() },
                title: { EmptyView().embedInAnyView() },
                action: {},
                style: .init(background: .yellow, slotHeight: 64)
            )]
        }
    }
    private var trailingSwipeActions: [Slot] {
        get { return displayFoldout ? [] : [Slot(
                image: { Image(systemName: .trashIcon).frame(width: .swipeActionIconSize, height: .swipeActionIconSize).embedInAnyView() },
                title: { EmptyView().embedInAnyView() },
                action: { deleteAction(version) },
                style: .init(background: .red, slotHeight: 64)
            )]
        }
    }

    var body: some View {
        VStack {
            Button(action: { displayFoldout.toggle() }) {
                mainButton()
            }
            .frame(minWidth: 64, maxWidth: .infinity, minHeight: 40, maxHeight: 40)
            .contentShape(Rectangle())
            
            if displayFoldout {
                ForEach(modules) { module in
                    InstalledModuleButton(version: version, module: module, deleteAction: prepareForDeletion)
                }
                .onDelete(perform: prepareForDeletion)
            }
        }
        .padding(.vertical, 12)
        .buttonStyle(PlainButtonStyle())
        .onAppear { modules = version.getInstalledModules() }
        .sheet(isPresented: $showInstallSheet) { InstallModuleSheet(selectedVersion: version) }
        .alert(isPresented: $showRemovalSheet) { alertPanel() }
        .onSwipe(leading: leadingSwipeActions, trailing: trailingSwipeActions)
    }
    
    func mainButton() -> some View {
        HStack {
            if !installing {
                SVGShapes.UnityCube()
                    .frame(width: 32, height: 32)
                    .padding(.leading, 16)
            } else {
                ProgressView()
                    .frame(width: 32, height: 32)
                    .padding(.leading, 16)
            }
            
            versionAndLocation()
            
            if version.isPrerelease() || version.lts {
                PrereleaseTag(version: version)
                    .padding(.horizontal, 4)
            }
            Spacer()
            rightSide()
        }
    }
    
    func versionAndLocation() -> some View {
        VStack(alignment: .leading) {
            if !settings.hub.alwaysShowLocation {
                Text(version.version)
                    .font(.system(size: 12, weight: .semibold))
                    .help(version.path)
            } else {
                Text(version.version)
                    .font(.system(size: 12, weight: .semibold))
                Text(version.path)
                    .font(.system(size: 11, weight: .regular))
                    .opacity(0.5)
            }
        }
    }
    
    func rightSide() -> some View {
        HStack {
            if settings.hub.showFileSizes {
                Text(getVersionSize())
            }
            ForEach(modules) { item in
                if let icon = item.getIcon() {
                    icon
                        .frame(width: 16, height: 16)
                        .help(item.getDisplayName() ?? "")
                }
            }
            Menu {
                Button("Install Additional Modules", action: installModuleSheet)
                //
                Button("Set as Default", action: {  })
                Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: version.path) })
                Button("Uninstall Version", action: { deleteAction(version) })
            } label: {}
            .labelsHidden()
            .menuStyle(BorderlessButtonMenuStyle())
            .frame(width: 16)
            .padding(.trailing, 16)
        }
    }
    
    func alertPanel() -> Alert {
        Alert(
            title: Text("Uninstall \(moduleToRemove!.getDisplayName()!) module"),
            message: Text("Are you sure you want to uninstall the \(moduleToRemove!.getDisplayName()!) module for Unity \(version.version)?"),
            primaryButton: .cancel(Text("Cancel")),
            secondaryButton: .destructive(Text("Uninstall")) { deleteItems(module: moduleToRemove) }
        )
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
            version.removeModule(module: m)
            modules.removeAll { $0.id == m.id }
        }
        moduleToRemove = nil
    }
    
    func getVersionSize() -> String {
        let url = URL(fileURLWithPath: version.path)
        do {
            let result = try url.sizeOnDisk() ?? ""
            return result
        } catch {
            return ""
        }
    }
}
