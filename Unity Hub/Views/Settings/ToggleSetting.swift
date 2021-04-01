//
//  ToggleSetting.swift
//  Unity Hub S
//
//  Created by RyanBoyer on 3/10/21.
//

import SwiftUI

struct ToggleSetting: View {
    @EnvironmentObject var settings: HubSettings

    let label: String
    
    @Binding var toggle: Bool
    
    let isFirst: Bool
    let isLast: Bool
    
    init(label: String, toggle: Binding<Bool>, isFirst: Bool = false, isLast: Bool = false) {
        self.label = label
        self._toggle = toggle
        self.isFirst = isFirst
        self.isLast = isLast
    }
    
    var body: some View {
        HStack {
            Toggle("", isOn: $toggle)
                .toggleStyle(SwitchToggleStyle())
                .labelsHidden()
            Text(label)
        }
        .padding(.top, isFirst ? -4 : 0)
        .padding(.bottom, isLast ? 8 : 0)
        .onChange(of: toggle) { _ in
            settings.wrap()
        }
    }
}
