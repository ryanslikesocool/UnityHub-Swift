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
    @Binding var module: ModuleJSON
    let deleteAction: (ModuleJSON) -> Void

    private var trailingSwipeActions: [Slot] { return [Slot(
        image: { Image(systemName: .trashIcon).frame(width: .swipeActionSmallIconSize, height: .swipeActionSmallIconSize).embedInAnyView() },
        title: { EmptyView().embedInAnyView() },
        action: { deleteAction(module) },
        style: .init(background: .red, slotHeight: .smallListItemHeight)
    )]
    }

    var body: some View {
        HStack {
            if let icon = module.module.getIcon() {
                icon
                    .frame(width: 20, height: 20)
            }
            if let name = module.module.getDisplayName() {
                Text(name)
            }
            Spacer()
            if settings.hub.showFileSize {
                let sizeBinding = Binding(get: { module.fileSize ?? "" }, set: { module.fileSize = $0 })

                LoadingText(text: sizeBinding)
                    .padding(.trailing, 8)
            }

            Menu {
                Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: "\(version.path)\(module.module.getInstallPath()!)") })
                Button("Uninstall Module", action: { deleteAction(module) })
            } label: {}
                .labelsHidden()
                .menuStyle(BorderlessButtonMenuStyle())
                .frame(width: 16)
                .padding(.trailing, 40)
        }
        .padding(.leading, 32)
        .frame(height: .smallListItemHeight)
        .contentShape(Rectangle())
        // .onSwipe(trailing: trailingSwipeActions)
        .onAppear {
            if settings.hub.showFileSize && (module.fileSize == nil || module.fileSize == "" || module.fileSize == ".") {
                getModuleSize()
            }
        }
        .onChange(of: settings.hub.showFileSize, perform: { toggle in
            if toggle, module.fileSize == nil || module.fileSize == "" || module.fileSize == "." {
                getModuleSize()
            }
        })
    }

    func getModuleSize() {
        if let path = module.module.getInstallPath() {
            module.fileSize = "."
            DispatchQueue.global(qos: .background).async {
                let url = URL(fileURLWithPath: "\(version.path)\(path)")
                var size = ""
                do {
                    size = try url.sizeOnDisk() ?? ""
                } catch {
                    print(error.localizedDescription)
                }

                DispatchQueue.main.async {
                    module.fileSize = size
                }
            }
        }
    }
}
