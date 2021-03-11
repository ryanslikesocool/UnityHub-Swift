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
        case .projects: ProjectPanel()
        case .installs: InstalledVersionPanel()
        }
    }
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        TabSelector(item: .projects)
    }
}
