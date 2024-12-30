import UnityHubStorageInstallations

enum SearchToken {
	case lts(Bool)
	case prerelease(Bool)
	case majorVersion(SemanticVersion.Integer)
}

// MARK: - Sendable

extension SearchToken: Sendable { }

// MARK: - Equatable

extension SearchToken: Equatable { }

// MARK: - Hashable

extension SearchToken: Hashable { }

// MARK: - Identifiable

extension SearchToken: Identifiable {
	var id: Int {
		/// only needs to be unique against itself in a single runtime.  hash value will suffice
		hashValue
	}
}

// MARK: -

extension SearchToken {
	var kind: Kind {
		switch self {
			case .lts: .lts
			case .prerelease: .prerelease
			case .majorVersion: .majorVersion
		}
	}
}
