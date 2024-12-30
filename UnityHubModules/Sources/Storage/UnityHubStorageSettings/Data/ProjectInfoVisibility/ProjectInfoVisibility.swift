public enum ProjectInfoVisibility: UInt8 {
	case location
	case lastOpened
	case icon
	case editorVersion
	case editorVersionBadge
}

// MARK: - Sendable

extension ProjectInfoVisibility: Sendable { }

// MARK: - Equatable

extension ProjectInfoVisibility: Equatable { }

// MARK: - Hashable

extension ProjectInfoVisibility: Hashable { }

// MARK: - Identifiable

extension ProjectInfoVisibility: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension ProjectInfoVisibility: Codable { }

// MARK: - CaseIterable

extension ProjectInfoVisibility: CaseIterable { }
