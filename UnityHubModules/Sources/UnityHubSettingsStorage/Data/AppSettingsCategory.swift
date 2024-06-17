public enum AppSettingsCategory: UInt8 {
	case general
	case projects
}

// MARK: - Hashable

extension AppSettingsCategory: Hashable { }

// MARK: - Identifiable

extension AppSettingsCategory: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - CaseIterable

extension AppSettingsCategory: CaseIterable { }

// MARK: - CustomStringConvertible

extension AppSettingsCategory: CustomStringConvertible {
	public var description: String {
		switch self {
			case .general: "General"
			case .projects: "Projects"
		}
	}
}

// MARK: -

public extension AppSettingsCategory {
	var systemImageName: String {
		switch self {
			case .general: "gearshape"
			case .projects: "cube"
		}
	}
}
