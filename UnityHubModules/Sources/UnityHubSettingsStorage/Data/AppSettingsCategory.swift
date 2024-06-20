public enum AppSettingsCategory: UInt8 {
	case general
	case projects
	case installations
}

// MARK: - Hashable

extension AppSettingsCategory: Hashable { }

// MARK: - Identifiable

extension AppSettingsCategory: Identifiable {
	public var id: RawValue { rawValue }
}
