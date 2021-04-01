//
//  LargeModule.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/4/21.
//

import SwiftUI

struct ModuleButton: View {
    @EnvironmentObject var settings: HubSettings

    let version: UnityVersion
    let module: UnityModule
    let deleteAction: (UnityModule) -> Void

    @State private var fileSize: String = ""

    private var trailingSwipeActions: [Slot] { return [Slot(
        image: { Image(systemName: .trashIcon).frame(width: .swipeActionSmallIconSize, height: .swipeActionSmallIconSize).embedInAnyView() },
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
            if settings.hub.showFileSize {
                LoadingText(text: $fileSize)
                    .padding(.trailing, 8)
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
        .onAppear {
            getModuleSize()
        }
    }

    func getModuleSize() {
        if let path = module.getInstallPath() {
            DispatchQueue.global(qos: .background).async {
                let url = URL(fileURLWithPath: "\(version.path)\(path)")
                var size = ""
                do {
                    size = try url.sizeOnDisk() ?? ""
                } catch {
                    print(error.localizedDescription)
                }

                DispatchQueue.main.async {
                    fileSize = size
                }
            }
        }
    }
}
