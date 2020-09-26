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

extension SidebarItem: RawRepresentable {
    // (order, label, icon)
    typealias RawValue = (Int, String, String)
    
    init?(rawValue: (Int, String, String)) {
        switch(rawValue.0) {
        case 0: self = .projects
        case 1: self = .learn
        case 2: self = .community
        case 3: self = .installs
        default: return nil
        }
    }
    
    var rawValue: (Int, String, String) {
        switch self {
        case .projects: return (0, "Projects", "cube.fill")
        case .learn: return (1, "Learn", "graduationcap.fill")
        case .community: return (2, "Community", "person.2.fill")
        case .installs: return (3, "Installs", "list.dash")
        }
    }
}

extension SidebarItem: Identifiable {
    var id: Int {
        rawValue.0
    }
}
