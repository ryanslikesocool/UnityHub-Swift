public enum BackgroundMode: String {
	case none
	case hide
	case quit
}

// MARK: - Hashable

extension BackgroundMode: Hashable { }

// MARK: - Identifiable

extension BackgroundMode: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension BackgroundMode: Codable { }
