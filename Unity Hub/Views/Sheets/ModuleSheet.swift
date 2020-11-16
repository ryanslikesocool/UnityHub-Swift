//
//  ModuleSheet.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 11/15/20.
//

import SwiftUI

struct ModuleSheet: View {
    @Binding var selectedModules: [Bool]
    @Binding var availableModules: [UnityModule]
    
    var body: some View {
        Form {
            ScrollView {
                ForEach(0 ..< availableModules.count, id: \.self) { i in
                    HStack {
                        Toggle(availableModules[i].getDisplayName()!, isOn: $selectedModules[i])
                        Spacer()
                    }
                }
            }
        }
        .frame(width: 256, height: 256)
        .tabItem { Text("Modules") }
        .tag("Modules")
        .padding()
    }
}
