public enum CacheCategory: UInt8 {
	case projects
	case installations
}

// MARK: - Sendable

extension CacheCategory: Sendable { }

// MARK: - Equatable

extension CacheCategory: Equatable { }

// MARK: - Hashable

extension CacheCategory: Hashable { }

// MARK: -

extension CacheCategory {
	var fileName: String {
		switch self {
			case .projects: "projects"
			case .installations: "installations"
		}
	}
}
