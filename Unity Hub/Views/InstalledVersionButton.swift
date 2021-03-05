//
//  UnityVersionButton.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct InstalledVersionButton: View {
    @EnvironmentObject var settings: HubSettings
    var version: UnityVersion
    var hideRightSide: Bool = false
    var action: () -> Void
    
    @State private var modules: [UnityModule] = []
    @State private var installing: Bool = false
    @State private var showModuleSheet: Bool = false

    @Binding var alwaysShowLocation: Bool

    var deleteAction: (UnityVersion) -> Void

    var body: some View {
        return Button(action: action) {
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
                if !hideRightSide {
                    rightSide()
                }
            }
            .frame(minWidth: 64, maxWidth: .infinity, minHeight: 64, maxHeight: 64)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            modules = HubSettings.getInstalledModules(version: version)
        }
        .sheet(isPresented: $showModuleSheet) { InstallModuleSheet(selectedVersion: version) }
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
            .menuStyle(BorderlessButtonMenuStyle())
            .frame(width: 16, height: 48)
            .padding(.trailing, 16)
        }
    }
    
    func installModuleSheet() {
        showModuleSheet.toggle()
    }
}
