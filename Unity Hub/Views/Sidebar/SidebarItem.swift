//
//  SidebarItems.swift
//  Unity Hub
//
//  Created by Ryan Boyer on 9/22/20.
//

import Foundation

enum SidebarItem: Int {
    case projects = 0
    case installs = 1
}

extension SidebarItem {
    func asText() -> String {
        switch self {
        case .projects: return "Projects"
        case .installs: return "Installs"
        }
    }
    
    func asSymbol() -> String {
        switch self {
        case .projects: return "cube.fill"
        case .installs: return "list.dash"
        }
    }
    
    func asSubtitleText(settings: HubSettings) -> String {
        switch self {
        case .projects: return String(settings.projects.count)
        case .installs: return String(settings.versionsInstalled.count)
        }
    }
}

extension SidebarItem: CaseIterable{}

extension SidebarItem: Identifiable {
    var id: Int {
        self.rawValue
    }
}
