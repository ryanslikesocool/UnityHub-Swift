import Foundation

public enum SettingsCategory: UInt8 {
	case general
	case projects
	case installations
	case locations
#if DEBUG
	case development
#endif
}

// MARK: - Sendable

extension SettingsCategory: Sendable { }

// MARK: - Equatable

extension SettingsCategory: Equatable { }

// MARK: - Hashable

extension SettingsCategory: Hashable { }

// MARK: - Identifiable

extension SettingsCategory: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Constants

private extension SettingsCategory  {
	static let fileExtension: String = "plist"

	static let directory: URL = URL.persistentStorageDirectory
		.appending(component: "settings", directoryHint: .isDirectory)
}

// MARK: -

extension SettingsCategory {
	var fileName: String {
		switch self {
			case .general: "general"
			case .projects: "projects"
			case .installations: "installations"
			case .locations: "locations"
#if DEBUG
			case .development: "development"
#endif
		}
	}

	var fileURL: URL {
		Self.directory
			.appending(component: "\(fileName).\(Self.fileExtension)", directoryHint: .notDirectory)
	}
}
