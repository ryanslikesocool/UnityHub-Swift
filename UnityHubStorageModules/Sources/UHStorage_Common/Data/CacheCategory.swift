public enum CacheCategory: UInt8 {
	case projects
	case installations
}

// MARK: -

extension CacheCategory {
	var fileName: String {
		switch self {
			case .projects: "projects"
			case .installations: "installations"
		}
	}
}
