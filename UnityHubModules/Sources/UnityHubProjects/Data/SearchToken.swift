import UnityHubStorage

enum SearchToken {
	case pinned(Bool)
	case editorVersion(UnityEditorVersion)
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
			case .pinned: .pinned
			case .editorVersion: .editorVersion
		}
	}
}
