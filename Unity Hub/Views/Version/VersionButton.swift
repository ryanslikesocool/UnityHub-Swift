//
//  UnityVersionButton.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct VersionButton: View {
    @EnvironmentObject var settings: HubSettings
    
    @Binding var viewWidth: CGFloat
    
    @Binding var version: UnityVersion
    let deleteAction: (UnityVersion) -> Void

    @State private var installing: Bool = false
    @State private var showInstallSheet: Bool = false
    @State private var displayFoldout: Bool = false
    
    @State private var showRemovalSheet: Bool = false
    @State private var moduleToRemove: ModuleJSON? = nil
    
    private var leadingSwipeActions: [Slot] { return displayFoldout ? [] : [Slot(
        image: { Image(systemName: "star.fill").frame(width: .swipeActionLargeIconSize, height: .swipeActionLargeIconSize).embedInAnyView() },
        title: { EmptyView().embedInAnyView() },
        action: { settings.setDefaultVersion(version) },
        style: .init(background: .yellow, slotHeight: .listItemHeight)
    )]
    }

    private var trailingSwipeActions: [Slot] { return displayFoldout ? [] : [Slot(
        image: { Image(systemName: .trashIcon).frame(width: .swipeActionLargeIconSize, height: .swipeActionLargeIconSize).embedInAnyView() },
        title: { EmptyView().embedInAnyView() },
        action: { deleteAction(version) },
        style: .init(background: .red, slotHeight: .listItemHeight)
    )]
    }
    
    var body: some View {
        return VStack {
            Button(action: { displayFoldout.toggle() }) {
                mainButton()
            }
            .frame(height: .listItemHeight)
            .contentShape(Rectangle())
            
            if displayFoldout {
                ForEach(version.installedModules) { module in
                    let moduleBinding = Binding(get: { return module }, set: { version.modules.setElement($0, where: { $0.module == module.module }) })
                    
                    Divider()
                        .padding(.leading, 32)
                    ModuleButton(version: version, module: moduleBinding, deleteAction: prepareForDeletion)
                }
                // .onDelete(perform: prepareForDeletion)
            }
        }
        .frame(width: viewWidth)
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            if settings.hub.showFileSize && (version.fileSize == "" || version.fileSize == ".") {
                getVersionSize()
            }
        }
        .onChange(of: settings.hub.showFileSize, perform: { toggle in
            if toggle, version.fileSize == "" || version.fileSize == "." {
                getVersionSize()
            }
        })
        .sheet(isPresented: $showInstallSheet) { InstallModuleSheet(selectedVersion: version) }
        .alert(isPresented: $showRemovalSheet) { alertPanel() }
        // .onSwipe(leading: leadingSwipeActions, trailing: trailingSwipeActions)
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
            if settings.isDefaultVersion(version) {
                Image(systemName: "star.fill")
                    .font(.system(size: 13, weight: .semibold))
                    .padding(.horizontal, 4)
            }
            Spacer()
            rightSide()
        }
    }
    
    func versionAndLocation() -> some View {
        VStack(alignment: .leading) {
            if !settings.hub.showLocation {
                Text(version.version)
                    .font(.system(size: 12, weight: .semibold))
                    .help(version.localPath)
            } else {
                Text(version.version)
                    .font(.system(size: 12, weight: .semibold))
                Text(version.localPath)
                    .font(.system(size: 10, weight: .regular))
                    .opacity(0.5)
            }
        }
    }
    
    func rightSide() -> some View {
        HStack {
            if settings.hub.showFileSize {
                LoadingText(text: $version.fileSize)
                    .padding(.trailing, 8)
            }
            ForEach(version.installedModules) { item in
                if let icon = item.module.getIcon() {
                    icon
                        .frame(width: 16, height: 16)
                        .help(item.module.getDisplayName() ?? "")
                }
            }
            Menu {
                Button("Install Additional Modules", action: installModuleSheet)
                Button(settings.hub.defaultVersion == version ? "Unset as Default Version" : "Set as Default Version", action: { settings.setDefaultVersion(version) })
                Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: version.path) })
                Button("Uninstall Version", action: { deleteAction(version) })
            } label: {}
                .labelsHidden()
                .menuStyle(BorderlessButtonMenuStyle())
                .frame(width: 16)
                .padding(.trailing, 16)
        }
        .padding(.trailing, 24)
    }
    
    func alertPanel() -> Alert {
        Alert(
            title: Text("Uninstall \(moduleToRemove!.module.getDisplayName()!) module"),
            message: Text("Are you sure you want to uninstall the \(moduleToRemove!.module.getDisplayName()!) module for Unity \(version.version)?"),
            primaryButton: .cancel(Text("Cancel")),
            secondaryButton: .destructive(Text("Uninstall")) { deleteItems(module: moduleToRemove) }
        )
    }
    
    func installModuleSheet() {
        showInstallSheet.toggle()
    }
    
    func prepareForDeletion(offsets: IndexSet) {
        prepareForDeletion(module: version.installedModules[offsets.first!])
    }
    
    func prepareForDeletion(module: ModuleJSON) {
        moduleToRemove = module
        showRemovalSheet.toggle()
    }
    
    func deleteItems(module: ModuleJSON?) {
        if let m = module {
            ModuleJSON.removeModule(version, module: m, settings: settings)
        }
        moduleToRemove = nil
    }
    
    func getVersionSize() {
        version.fileSize = "."
        DispatchQueue.global(qos: .background).async {
            let url = URL(fileURLWithPath: version.path)
            var size = ""
            do {
                size = try url.sizeOnDisk() ?? ""
            } catch {
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                version.fileSize = size
            }
        }
    }
}
