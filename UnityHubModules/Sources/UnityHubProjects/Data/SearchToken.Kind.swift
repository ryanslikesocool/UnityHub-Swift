extension SearchToken {
	enum Kind: UInt8 {
		case pinned
		case editorVersion
	}
}

// MARK: - Hashable

extension SearchToken.Kind: Hashable { }

// MARK: - Identifiable

extension SearchToken.Kind: Identifiable {
	var id: RawValue { rawValue }
}
