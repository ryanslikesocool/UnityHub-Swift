//
//  LargeModule.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/4/21.
//

import SwiftUI

struct InstalledModuleButton: View {
    var version: UnityVersion
    var module: UnityModule
    var deleteAction: (UnityModule) -> Void
    
    var body: some View {
        HStack {
            if let icon = module.getIcon() {
                icon
                    .frame(width: 16, height: 16)
            }
            if let name = module.getDisplayName() {
                Text(name)
            }
            Spacer()
            Menu {
                Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: "\(version.path)\(module.getInstallPath()!)") })
                Button("Uninstall Module", action: { deleteAction(module) })
            } label: {}
            .labelsHidden()
            .menuStyle(BorderlessButtonMenuStyle())
            .frame(width: 16)
            .padding(.trailing, 16)
        }
        .padding(.leading, 32)
    }
}
