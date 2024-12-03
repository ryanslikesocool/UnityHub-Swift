public enum ProjectSortCriteria: UInt8 {
	case name
	case editorVersion
	case lastOpened
}

// MARK: - Sendable

extension ProjectSortCriteria: Sendable { }

// MARK: - Equatable

extension ProjectSortCriteria: Equatable { }

// MARK: - Hashable

extension ProjectSortCriteria: Hashable { }

// MARK: - Identifiable

extension ProjectSortCriteria: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension ProjectSortCriteria: Codable { }