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
                VStack(spacing: 4) {
                    ForEach(settings.hub.versions) { version in
                        //REPLACE THIS WITH A DEDICATED ITEM
                        //InstalledVersionButton(version: version, hideRightSide: true, action: { selectVersion(version: version) }, deleteAction: {})
                    }
                }
                .padding(.top, 56)
                .padding(.bottom, 16)
            }
            .padding(.horizontal)
            VStack {
                HStack {
                    Button("Cancel", action: { presentationMode.wrappedValue.dismiss() })
                        .padding(8)
                        .buttonStyle(UnityButtonStyle())
                    Spacer()
                }
                .background(VisualEffectView(material: .headerView))
                Spacer()
            }
        }
        .frame(width: 256, height: 192)
    }
    
    func selectVersion(version: UnityVersion) {
        self.version = version
        presentationMode.wrappedValue.dismiss()
        action()
    }
}
