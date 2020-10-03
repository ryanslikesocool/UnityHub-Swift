//
//  Tab.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import SwiftUI

struct TabSelector: View {
    var item: SidebarItem
    
    var body: some View {
        switch item {
        case .projects: ProjectTab()
        case .installs: InstallsTab()
        default: Rectangle()
        }
    }
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        TabSelector(item: .projects)
    }
}
