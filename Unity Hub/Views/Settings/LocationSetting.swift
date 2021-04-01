//
//  LocationSetting.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/10/21.
//

import SwiftUI

struct LocationSetting: View {
    @EnvironmentObject var settings: HubSettings

    let label: String
    let symbol: String
    
    let prompt: String
    let isDirectory: Bool
    let assignAction: (String) -> Void
    
    @State var location: String
    
    var localPath: String {
        let url = URL(fileURLWithPath: location)
        let homeDir = FileManager.default.homeDirectoryForCurrentUser
        return url.relativePath.replacingOccurrences(of: homeDir.relativePath, with: "~")
    }
    
    let isFirst: Bool
    let isLast: Bool
    
    init(label: String, symbol: String, prompt: String, isDirectory: Bool, assignAction: @escaping (String) -> Void, location: String, isFirst: Bool = false, isLast: Bool = false) {
        self.label = label
        self.symbol = symbol
        self.prompt = prompt
        self.isDirectory = isDirectory
        self.assignAction = assignAction
        self._location = State(initialValue: location)
        self.isFirst = isFirst
        self.isLast = isLast
    }
    
    var body: some View {
        Group {
            HStack {
                Button(action: { pickFile(prompt, isDirectory: isDirectory, assignAction: assignAction) }) {
                    Image(systemName: symbol)
                }
                Text(label)
                Spacer()
            }
            .padding(.top, isFirst ? -4 : 0)
            Text(localPath.replacingOccurrences(of: #"\"#, with: ""))
                .font(.system(size: 11, weight: .semibold, design: .monospaced))
                .opacity(0.75)
                .padding(.top, -4)
                .padding(.bottom, isLast ? 8 : 0)
        }
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
                location = result!.path.replacingOccurrences(of: #" "#, with: #"\ "#)
                assignAction(location)
                settings.wrap()
            }
        }
    }
}
