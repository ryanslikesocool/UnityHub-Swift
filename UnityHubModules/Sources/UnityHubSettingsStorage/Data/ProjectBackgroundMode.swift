public enum ProjectBackgroundMode: String {
	case none
	case hide
	case quit
}

// MARK: - Hashable

extension ProjectBackgroundMode: Hashable { }

// MARK: - Identifiable

extension ProjectBackgroundMode: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension ProjectBackgroundMode: Codable { }
