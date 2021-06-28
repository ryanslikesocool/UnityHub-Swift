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
		ScrollView {
			ForEach(availableModules, id: \.self) { module in
				HStack {
					if let binding = selectedModules[module] {
						let bindingValue = Binding(get: { binding }, set: { selectedModules[module] = $0 })
						Toggle(module.getDisplayName()!, isOn: bindingValue)
						Spacer()
					}
				}
			}
			.padding(.vertical)
		}
		.frame(width: 200)
		.frame(minHeight: 200)
		.tabItem { Text("Modules") }
		.tag("Modules")
	}
}
