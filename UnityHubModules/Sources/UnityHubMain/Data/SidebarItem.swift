enum SidebarItem: UInt8 {
	case projects
	case installations
	case resources
}

// MARK: - Hashable

extension SidebarItem: Hashable { }

// MARK: - Identifiable

extension SidebarItem: Identifiable {
	var id: RawValue { rawValue }
}

// MARK: - CaseIterable

extension SidebarItem: CaseIterable { }
