//
//  SelectProjectVersionSheet.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/29/20.
//

import SwiftUI

struct SelectProjectVersionSheet: View {
    @EnvironmentObject var settings: HubSettings
    @Environment(\.presentationMode) var presentationMode
    @Binding var version: UnityVersion
    
    var action: () -> Void
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(settings.versionsInstalled, id: \.self.0) { version in
                        UnityVersionButton(path: version.0, version: version.1, hideRightSide: true, action: { selectVersion(version: version.1) })
                    }
                }
                .padding(.top, 48)
            }
            .padding(.horizontal)
            VStack {
                HStack {
                    Button("Cancel", action: { presentationMode.wrappedValue.dismiss() })
                        .buttonStyle(UnityButtonStyle())
                    Spacer()
                }
                .padding(8)
                .background(VisualEffectView(material: .headerView))
                Spacer()
            }
        }
        .frame(width: 320, height: 256)
    }
    
    func selectVersion(version: UnityVersion) {
        self.version = version
        presentationMode.wrappedValue.dismiss()
        action()
    }
}
