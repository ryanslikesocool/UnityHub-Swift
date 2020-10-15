//
//  SimpleProjectButton.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 10/6/20.
//

import SwiftUI

struct SimpleProjectButton: View {
    @EnvironmentObject var settings: HubSettings
    var path: String
    var project: String
    var version: UnityVersion
    @State private var emoji: String = ""

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
            }
        }
        .buttonStyle(UnityButtonStyle(cornerRadius: 12, backgroundColor: .white, verticalPadding: 0, horizontalPadding: 0))
        .onAppear {
            emoji = HubSettings.getProjectEmoji(project: project)
            shellCommand = getShellCommand()
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
            //selectProjectVersion()
        }
    }
}
