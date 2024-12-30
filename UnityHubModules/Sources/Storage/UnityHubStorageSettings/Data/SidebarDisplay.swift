public enum SidebarDisplay: String {
	case standard
	case compact
}

// MARK: - Sendable

extension SidebarDisplay: Sendable { }

// MARK: - Equatable

extension SidebarDisplay: Equatable { }

// MARK: - Hashable

extension SidebarDisplay: Hashable { }

// MARK: - Identifiable

extension SidebarDisplay: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension SidebarDisplay: Codable { }
