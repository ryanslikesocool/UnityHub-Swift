//
//  SettingsProjectPanel.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/4/21.
//

import SwiftUI

struct SettingsProjectPanel: View {
    @Binding var useEmoji: Bool
    @Binding var usePins: Bool
    @Binding var alwaysShowLocation: Bool
    
    var body: some View {
        Section(header: Text("Project Panel").font(.title)) {
            HStack {
                Toggle("", isOn: $useEmoji)
                    .toggleStyle(SwitchToggleStyle())
                    .labelsHidden()
                Text("Use Emoji")
            }
            .padding(.top, -4)
            HStack {
                Toggle("", isOn: $usePins)
                    .toggleStyle(SwitchToggleStyle())
                    .labelsHidden()
                Text("Use Pins")
            }
            HStack {
                Toggle("", isOn: $alwaysShowLocation)
                    .toggleStyle(SwitchToggleStyle())
                    .labelsHidden()
                Text("Always Show Location")
            }
        }
    }
}
