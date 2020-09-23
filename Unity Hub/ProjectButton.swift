//
//  ProjectButton.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import SwiftUI

struct ProjectButton: View {
    @EnvironmentObject var settings: HubSettings

    var path: String
    var project: String
    var version: String
    @Binding var updateList: Bool
    
    var body: some View {
        Button(action: openProject) {
            HStack {
                Text(project)
                    .font(.system(size: 12, weight: .bold))
                    .padding(.leading, 12)

                Spacer()
                
                Text("Unity \(version)")
                
                Menu {
                    Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: path) })
                    Button("Advanced", action: {})
                    Button("Remove", action: {
                        settings.projectPaths.removeAll(where: { $0 == path })
                        updateList.toggle()
                    })
                } label: {}
                .menuStyle(BorderlessButtonMenuStyle())
                .frame(width: 32, height: 48)
                .padding(.trailing, 16)
            }
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .frame(minWidth: 64, maxWidth: .infinity, minHeight: 48, maxHeight: 48)
                    .foregroundColor(Color(.windowBackgroundColor).opacity(0.5))
            )
            .foregroundColor(Color(.textColor))
            .frame(minWidth: 64, maxWidth: .infinity, minHeight: 48, maxHeight: 48)
            .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    func openProject() {
        
    }
}
