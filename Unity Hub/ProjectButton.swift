//
//  ProjectButton.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import SwiftUI
import Cocoa

struct ProjectButton: View {
    @EnvironmentObject var settings: HubSettings

    var path: String
    var project: String
    var version: String
    @Binding var updateList: Bool
    
    @State private var emoji: String = ""
    @State private var isPickerOpen: Bool = false

    @State private var shellCommand: String? = nil
    @State private var showWarning: Bool = false
    
    var body: some View {
        Button(action: openProject) {
            HStack {
                Text(emoji)
                .padding(.leading, 8)
                .font(.system(size: 16))
                Text(project)
                    .font(.system(size: 12, weight: .bold))
                    .help(path)
                Spacer()
                if showWarning {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .help("The Editor version associated with this project is not currently available on this machine.  Go to Installs to download a matching version")
                }
                Text("Unity \(version)")
                Menu {
                    Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: path) })
                    Button("Edit Emoji", action: { isPickerOpen.toggle() } )
                    Button("Advanced", action: {})
                    Button("Remove", action: removeProject)
                } label: {}
                .menuStyle(BorderlessButtonMenuStyle())
                .frame(width: 16, height: 48)
                .padding(.trailing, 16)
            }
            .background(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .frame(minWidth: 64, maxWidth: .infinity, minHeight: 48, maxHeight: 48)
                    .foregroundColor(Color(.windowBackgroundColor).opacity(0.375))
            )
            .foregroundColor(Color(.textColor))
            .frame(minWidth: 64, maxWidth: .infinity, minHeight: 48, maxHeight: 48)
            .padding(.vertical, 4)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            emoji = settings.getProjectEmoji(project: project)
            shellCommand = getShellCommand()
        }
        .sheet(isPresented: $isPickerOpen, content: {
            EmojiPicker(pickedEmoji: $emoji, action: { settings.setProjectEmoji(emoji: emoji, project: project) })
        })
    }
    
    func getShellCommand() -> String? {
        for version in settings.versionsInstalled {
            if version.1.version == self.version
            {
                let fullUnityPath = "\(version.0)/Unity.app/Contents/MacOS/Unity"
                let commands = "-projectPath"
                return "\(fullUnityPath) \(commands) \(path)"
            }
        }
        
        showWarning = true
        return nil
    }
    
    func openProject() {
        if !showWarning {
            let _ = shell(shellCommand!)
        }
    }
    
    func removeProject() {
        settings.projectPaths.removeAll(where: { $0 == path })
        updateList.toggle()
        settings.removeProjectEmoji(project: project)
    }
}
