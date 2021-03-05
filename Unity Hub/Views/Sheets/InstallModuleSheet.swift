//
//  InstallModuleSheet.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/4/21.
//

import SwiftUI

struct InstallModuleSheet: View {
    @EnvironmentObject var settings: HubSettings
    @Environment(\.presentationMode) var presentationMode

    @State var selectedVersion: UnityVersion
    
    @State private var selectedModules: [Bool] = []
    @State private var availableModules: [UnityModule] = []

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button("Cancel", action: closeMenu)
                    .buttonStyle(UnityButtonStyle())
                    .padding(8)
                Spacer()
            }
            ModuleSheet(selectedModules: $selectedModules, availableModules: $availableModules)
                .padding(.horizontal)
            HStack {
                Spacer()
                Button("Install", action: installSelectedItems)
                    .disabled(selectedVersion == UnityVersion.null)
                    .buttonStyle(UnityButtonStyle())
                    .padding(8)
            }
        }
        .onAppear {
            setupView()
        }
    }
    
    func setupView() {
        availableModules = UnityModule.getAvailableModules()
        let preinstalledModules = HubSettings.getInstalledModules(version: selectedVersion)
        availableModules.removeAll(where: { preinstalledModules.contains($0) })
        
        selectedModules = [Bool](repeating: false, count: availableModules.count)
    }
    
    func closeMenu() {
        presentationMode.wrappedValue.dismiss()
    }
    
    func installSelectedItems() {
        print("starting install")
        
        var command = "\(HubSettings.hubCommandBase) im --version \(selectedVersion.version)"
        
        for i in 0 ..< availableModules.count {
            if selectedModules[i] {
                command.append(" -m \(availableModules[i].rawValue)")
            }
        }
        
        selectedVersion.installing = true

        DispatchQueue.global(qos: .background).async {
            let string = shell(command)
            
            print(string)
            
            if string.contains("successfully downloaded") {
                selectedVersion.installing = false
            }
        }
                
        closeMenu()
    }
}
