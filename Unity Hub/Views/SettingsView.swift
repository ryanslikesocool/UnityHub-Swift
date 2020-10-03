//
//  Settingsview.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: HubSettings
    
    var body: some View {
        let hubLocation = Binding(
            get: { HubSettings.hubLocation },
            set: { HubSettings.hubLocation = $0 }
        )
        
        let installLocation = Binding(
            get: { HubSettings.installLocation },
            set: { HubSettings.installLocation = $0 }
        )
        
        VStack(alignment: .center) {
            Form {
                Text("Unity Hub v\(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? "0.0")")
                    .bold()
                Text("Hub Location")
                    .padding(.top, 8)
                    .padding(.bottom, -4)
                TextField("", text: hubLocation)
                    .font(.system(.body, design: .monospaced))
                    .labelsHidden()
                Text("Install Location")
                    .padding(.top, 8)
                    .padding(.bottom, -4)
                TextField("", text: installLocation)
                    .font(.system(.body, design: .monospaced))
                    .labelsHidden()
                Spacer()
            }
        }
        .padding()
    }
}
