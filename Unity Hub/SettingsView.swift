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
        let installLocation = Binding(
            get: { settings.installLocation },
            set: { settings.installLocation = $0 }
        )
        
        VStack(alignment: .center) {
            Form {
                Text("Unity Hub v\(Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? "0.0")")
                    .bold()
                    .padding(.bottom, 16)
                Text("Install Location")
                TextField("", text: installLocation)
                    .font(.system(.body, design: .monospaced))
                Spacer()
            }
        }
        .padding()
    }
}

struct Settingsview_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
