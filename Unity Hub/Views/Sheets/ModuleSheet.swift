//
//  ModuleSheet.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 11/15/20.
//

import SwiftUI

struct ModuleSheet: View {
    @Binding var selectedModules: [UnityModule: Bool]
    @Binding var availableModules: [UnityModule]

    var body: some View {
        Form {
            ScrollView {
                ForEach(availableModules, id: \.self) { module in
                    HStack {
                        if let binding = selectedModules[module] {
                            let bindingValue = Binding(get: { return binding }, set: { selectedModules[module] = $0 })
                            Toggle(module.getDisplayName()!, isOn: bindingValue)
                            Spacer()
                        }
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
