import UnityHubCommon

public extension ProjectInfoVisibility {
	typealias Set = EnumOptionSet<Self>
}

// MARK: - Constants

public extension ProjectInfoVisibility.Set {
	static let location: Self = Self(.location)
	static let lastOpened: Self = Self(.lastOpened)
	static let icon: Self = Self(.icon)
	static let editorVersion: Self = Self(.editorVersion)
	static let editorVersionBadge: Self = Self(.editorVersionBadge)

	static let all: Self = [.location, .lastOpened, .icon, .editorVersion, .editorVersionBadge]
}
