//
//  SidebarItems.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import Foundation

enum SidebarItem: CaseIterable {
    case projects
    case learn
    case community
    case installs
}

extension SidebarItem {
    func asOrder() -> Int {
        switch self {
        case .projects: return 0
        case .learn: return 1
        case .community: return 2
        case .installs: return 3
        }
    }
    
    func asText() -> String {
        switch self {
        case .projects: return "Projects"
        case .learn: return "Learn"
        case .community: return "Community"
        case .installs: return "Installs"
        }
    }
    
    func asSymbol() -> String {
        switch self {
        case .projects: return "cube.fill"
        case .learn: return "graduationcap.fill"
        case .community: return "person.2.fill"
        case .installs: return "list.dash"
        }
    }
}

extension SidebarItem: Identifiable {
    var id: Int {
        self.asOrder()
    }
}
