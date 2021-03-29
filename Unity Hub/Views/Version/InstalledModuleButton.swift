//
//  LargeModule.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/4/21.
//

import SwiftUI

struct InstalledModuleButton: View {
    @EnvironmentObject var settings: HubSettings

    let version: UnityVersion
    let module: UnityModule
    let deleteAction: (UnityModule) -> Void

    private var trailingSwipeActions: [Slot] { return [Slot(
        image: { Image(systemName: "trash.fill").frame(width: 16, height: 16).embedInAnyView() },
        title: { EmptyView().embedInAnyView() },
        action: { deleteAction(module) },
        style: .init(background: .red, slotHeight: 20)
    )]
    }

    var body: some View {
        HStack {
            if let icon = module.getIcon() {
                icon
                    .frame(width: 20, height: 20)
            }
            if let name = module.getDisplayName() {
                Text(name)
            }
            Spacer()
            if settings.hub.showFileSizes {
                Text(getModuleSize())
            }

            Menu {
                Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: "\(version.path)\(module.getInstallPath()!)") })
                Button("Uninstall Module", action: { deleteAction(module) })
            } label: {}
                .labelsHidden()
                .menuStyle(BorderlessButtonMenuStyle())
                .frame(width: 16)
                .padding(.trailing, 16)
        }
        .padding(.horizontal, 32)
        .contentShape(Rectangle())
        .onSwipe(trailing: trailingSwipeActions)
    }

    func getModuleSize() -> String {
        if let path = module.getInstallPath() {
            let url = URL(fileURLWithPath: "\(version.path)\(path)")
            do {
                return try url.sizeOnDisk() ?? ""
            } catch {
                return ""
            }
        }
        return ""
    }
}
