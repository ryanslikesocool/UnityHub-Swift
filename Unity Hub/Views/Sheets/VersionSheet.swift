//
//  VersionSheet.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 11/15/20.
//

import SwiftUI

struct VersionSheet: View {
    @Binding var selectedVersion: UnityVersion
    @Binding var availableVersions: [UnityVersion]

    var body: some View {
        Form {
            Picker("", selection: $selectedVersion) {
                ForEach(availableVersions, id: \.self) { version in
                    HStack {
                        Text(version.version)
                        if version.isAlpha() || version.isBeta() {
                            PrereleaseTag(version: version)
                        }
                    }
                    .tag(version)
                    .frame(height: 24)
                }
            }
            .labelsHidden()
            .pickerStyle(RadioGroupPickerStyle())
        }
        .frame(width: 256, height: 256)
        .tabItem { Text("Version") }
        .tag("Version")
        .padding()
    }
}
