import UnityHubStorage

enum ProjectSearchToken {
	case isPinned(Bool)
	case editorVersion(UnityEditorVersion)
}

// MARK: - Hashable

extension ProjectSearchToken: Hashable { }

// MARK: - Identifiable

extension ProjectSearchToken: Identifiable {
	var id: String {
		switch self {
			case let .isPinned(pinState): "\(Self.self).isPinned(\(pinState))"
			case let .editorVersion(editorVersion) : "\(Self.self).editorVersion(\(editorVersion))"
		}
	}
}

// MARK: -

extension ProjectSearchToken {
	var kind: Kind {
		switch self {
			case .isPinned: .isPinned
			case .editorVersion: .editorVersion
		}
	}
}
