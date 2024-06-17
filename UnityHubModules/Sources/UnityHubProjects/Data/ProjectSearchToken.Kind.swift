extension ProjectSearchToken {
	enum Kind: UInt8 {
		case isPinned
		case editorVersion
	}
}

// MARK: - Hashable

extension ProjectSearchToken.Kind: Hashable { }

// MARK: - Identifiable

extension ProjectSearchToken.Kind: Identifiable {
	var id: RawValue { rawValue }
}

// MARK: - CaseIterable

extension ProjectSearchToken.Kind: CaseIterable { }

// MARK: - CustomStringConvertible

extension ProjectSearchToken.Kind: CustomStringConvertible {
	var description: String {
		switch self {
			case .isPinned: "Pinned"
			case .editorVersion: "Editor Version"
		}
	}
}
