import Foundation
import SFSymbolToolbox
import UnityHubResources

enum SidebarItem: UInt8 {
	case projects
	case installations
	case resources
}

// MARK: - Sendable

extension SidebarItem: Sendable { }

// MARK: - Equatable

extension SidebarItem: Equatable { }

// MARK: - Hashable

extension SidebarItem: Hashable { }

// MARK: - Identifiable

extension SidebarItem: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - CaseIterable

extension SidebarItem: CaseIterable { }

// MARK: - CustomLocalizedStringResourceConvertible

extension SidebarItem: CustomLocalizedStringResourceConvertible {
	public var localizedStringResource: LocalizedStringResource {
		switch self {
			case .projects: .sidebar.item.projects
			case .installations: .sidebar.item.installations
			case .resources: .sidebar.item.resources
		}
	}
}

// MARK: -

extension SidebarItem {
	var systemImage: SystemSymbolName {
		switch self {
			case .projects: .cube
			case .installations: .tray
			case .resources: .info_circle
		}
	}
}