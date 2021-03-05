//
//  SwttingsLocations.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/4/21.
//

import SwiftUI

struct SettingsLocations: View {
    @State var hubLocation: String
    @State var installLocation: String
    @State var projectLocation: String
        
    var body: some View {
        Section(header: Text("Locations").font(.title)) {
            HStack {
                Button(action: { pickFile("Choose Unity Hub.app", isDirectory: false, assignAction: { hubLocation = $0 }) }) {
                    Image(systemName: "folder")
                }
                Text("Hub Location")
                Spacer()
            }
            .padding(.top, -4)
            Text(hubLocation)
                .font(.system(size: 11, weight: .semibold, design: .monospaced))
                .opacity(0.75)
                .padding(.top, -4)

            HStack {
                Button(action: { pickFile("Choose the default editor location", isDirectory: true, assignAction: { installLocation = $0 }) }) {
                    Image(systemName: "folder")
                }
                Text("Default Editor Location")
                Spacer()
            }
            Text(installLocation)
                .font(.system(size: 11, weight: .semibold, design: .monospaced))
                .opacity(0.75)
                .padding(.top, -4)

            HStack {
                Button(action: { pickFile("Choose the default project location", isDirectory: true, assignAction: { projectLocation = $0 }) }) {
                    Image(systemName: "folder")
                }
                Text("Default Project Location")
                Spacer()
            }
            Text(projectLocation)
                .font(.system(size: 11, weight: .semibold, design: .monospaced))
                .opacity(0.75)
                .padding(.top, -4)
                .padding(.bottom, 8)
        }
        .onChange(of: hubLocation) { HubSettings.hubLocation = $0 }
        .onChange(of: installLocation) { HubSettings.installLocation = $0 }
        .onChange(of: projectLocation) { HubSettings.projectLocation = $0 }
    }
    
    func pickFile(_ title: String, isDirectory: Bool, assignAction: (String) -> Void) {
        let dialog = NSOpenPanel();

        dialog.title = title
        dialog.showsResizeIndicator = true
        dialog.showsHiddenFiles = false
        dialog.allowsMultipleSelection = false
        dialog.canChooseDirectories = isDirectory

        if (dialog.runModal() ==  NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file

            if (result != nil) {
                let path: String = result!.path
                assignAction(path.replacingOccurrences(of: #" "#, with: #"\ "#))
            }
        } else {
            return
        }
    }
}
