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
    @State var version: UnityVersion
    @Binding var updateList: Bool
    
    @State private var emoji: String = ""

    @State private var shellCommand: String? = nil
    @State private var showWarning: Bool = false

    @State private var showSheet: Bool = false
    @State private var activeSheet: ActiveSheet?
        
    enum ActiveSheet: Identifiable {
        case emoji
        case selectVersion
        case advancedSettings
        
        var id: Int {
            hashValue
        }
    }
    
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
                Text("Unity \(version.version)")
                Menu {
                    Button("Reveal in Finder", action: { NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: path) })
                    Button("Edit Emoji", action: {
                        activeSheet = .emoji
                        showSheet.toggle()
                    })
                    Button("Select Unity Version", action: selectProjectVersion)
                    Button("Advanced", action: openAdvancedSettings)
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
            emoji = HubSettings.getProjectEmoji(project: project)
            shellCommand = getShellCommand()
        }
        .sheet(item: $activeSheet) { item in
            switch item {
            case .emoji: EmojiPicker(pickedEmoji: $emoji, action: { HubSettings.setProjectEmoji(emoji: emoji, project: project) })
            case .selectVersion: SelectProjectVersionSheet(version: $version, action: { shellCommand = getShellCommand() })
            case .advancedSettings: AdvancedProjectSettingsSheet()
            }
        }
    }
    
    func getShellCommand() -> String? {
        showWarning = false
        
        for version in settings.versionsInstalled {
            if version.1 == self.version
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
            DispatchQueue.global(qos: .background).async {
                let _ = shell(shellCommand!)
            }
        } else {
            selectProjectVersion()
        }
    }
    
    func selectProjectVersion() {
        activeSheet = .selectVersion
        showSheet.toggle()
    }
    
    func openAdvancedSettings() {
        activeSheet = .advancedSettings
        showSheet.toggle()
    }
    
    func removeProject() {
        HubSettings.projectPaths.removeAll(where: { $0 == path })
        updateList.toggle()
        HubSettings.removeProjectEmoji(project: project)
    }
}
