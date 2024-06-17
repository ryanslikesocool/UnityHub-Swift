import OSLog
import SerializationKit
import SwiftUI
import UnityHubCommon

@Observable
public final class AppSettings: GlobalFile {
	public static let shared: AppSettings = AppSettings.load()

	public var general: General { didSet { save() } }
	public var projects: Projects { didSet { save() } }

	public init() {
		general = General()
		projects = Projects()
	}
}

// MARK: - Codable

extension AppSettings: Codable {
	public enum CodingKeys: CodingKey {
		case general
		case projects
	}

	public convenience init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		general = try container.decodeIfPresent(forKey: .general) ?? general
		projects = try container.decodeIfPresent(forKey: .projects) ?? projects
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(general, forKey: .general)
		try container.encode(projects, forKey: .projects)
	}
}

// MARK: - Constants

public extension AppSettings {
	static let fileName: String = "Settings.plist"

	static var fileURL: URL {
		URL.applicationSupportDirectory
			.appending(component: Bundle.main.bundleIdentifier!, directoryHint: .isDirectory)
			.appending(component: fileName, directoryHint: .notDirectory)
	}
}
