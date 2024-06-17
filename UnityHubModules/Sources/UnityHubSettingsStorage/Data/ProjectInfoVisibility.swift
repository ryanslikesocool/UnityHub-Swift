public enum ProjectInfoVisibility: UInt8 {
	case name
	case location
	case editorVersion
	case lastOpened
	case icon
}

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
