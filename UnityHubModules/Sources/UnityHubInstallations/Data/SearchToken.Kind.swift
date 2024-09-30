extension SearchToken {
	enum Kind: UInt8 {
		case lts
		case prerelease
		case majorVersion
	}
}

// MARK: - Sendable

extension SearchToken.Kind: Sendable { }

// MARK: - Equatable

extension SearchToken.Kind: Equatable { }

// MARK: - Hashable

extension SearchToken.Kind: Hashable { }

// MARK: - Identifiable

extension SearchToken.Kind: Identifiable {
	var id: RawValue { rawValue }
}
