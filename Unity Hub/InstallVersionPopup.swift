//
//  InstallVersionPopup.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/23/20.
//

import SwiftUI

struct InstallVersionPopup: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var tab: String = "Version"
    @State private var selectedVersion: String = ""
    @State private var selectedModules: [UnityModule] = []
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12, style: .continuous)
            .overlay(
                VStack(alignment: .leading) {
                    Button("Cancel", action: closeMenu)
                    TabView(selection: $tab) {
                        Form {
                            Picker("", selection: $selectedVersion) {
                                ForEach(getLatestVersions(), id: \.self.version) { version in
                                    Text(version.version)
                                        .tag(version.version)
                                }
                            }.pickerStyle(RadioGroupPickerStyle())
                        }
                        .tabItem { Text("Version") }
                        .tag("Version")
                        
                        Form {
                            
                        }
                        .tabItem { Text("Modules") }
                        .tag("Modules")
                    }
                    
                    HStack {
                        Spacer()
                        Button("Install", action: installSelectedItems)
                            .disabled(selectedVersion == "")
                    }
                }
                .foregroundColor(Color(.textColor))
                .padding()
            )
            .frame(width: 256, height: 320)
            .foregroundColor(Color(.windowBackgroundColor))
    }
    
    func getLatestVersions() -> [UnityVersion] {
        return [UnityVersion("2020.2.0b2"), UnityVersion("2020.1.6f1"), UnityVersion("2019.4.11f1")]
    }
    
    func closeMenu() {
        presentationMode.wrappedValue.dismiss()
        tab = "Version"
        selectedVersion = ""
        selectedModules = []
    }
    
    func installSelectedItems() {
        
    }
}
