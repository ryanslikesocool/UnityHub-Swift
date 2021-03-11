//
//  SidebarItemView.swift
//  Unity Hub
//
//  Created by RyanBoyer on 3/3/21.
//

import SwiftUI

struct SidebarItemView: View {
    @EnvironmentObject var settings: HubSettings

    let enabled: Bool
    let item: SidebarItem
    
    @Binding var selectedItem: SidebarItem?
    
    var body: some View {
        NavigationLink(destination: TabSelector(item: item), tag: item, selection: $selectedItem) {
            HStack {
                Image(systemName: item.asSymbol())
                    .font(.system(size: 12, weight: .black))
                Text(item.asText())
                    .font(.system(size: 12, weight: .semibold))
                Spacer()
                if settings.showSidebarCount {
                    Text(item.asSubtitleText(settings: settings))
                        .font(.system(size: 12, weight: .regular))
                        .opacity(0.75)
                }
            }
            .frame(height: 24)
        }.disabled(!enabled)
    }
}

struct SidebarItemView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarItemView(enabled: true, item: .projects, selectedItem: .constant(.projects))
    }
}
