import UnityHubCommon

public extension InstallationInfoVisibility {
	typealias Set = EnumOptionSet<Self>
}

// MARK: - Constants

public extension InstallationInfoVisibility.Set {
	/// Corresponds to ``InstallationInfoVisibility/location``.
	static let location: Self = Self(.location)
	/// Corresponds to ``InstallationInfoVisibility/badge``.
	static let badge: Self = Self(.badge)

	static let all: Self = [.location, .badge]
}
