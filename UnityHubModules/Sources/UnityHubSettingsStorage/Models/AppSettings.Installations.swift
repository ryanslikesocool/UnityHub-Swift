import Foundation
import SerializationKit
import UnityHubCommon

public extension AppSettings {
	struct Installations: AppSettingsCategoryStorage {
		public static let category: AppSettingsCategory = .installations

		public var installationLocation: URL?
		public var downloadLocation: URL?
		public var sortOrder: SortOrder
		public var infoVisibility: InstallationInfoVisibility.Mask

		public init() {
			installationLocation = nil
			downloadLocation = nil
			sortOrder = .reverse
			infoVisibility = .all
		}
	}
}

// MARK: - Codable

public extension AppSettings.Installations {
	private enum CodingKeys: CodingKey {
		case installationLocation
		case downloadLocation
		case sortOrder
		case infoVisibility
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		installationLocation = try container.decodeIfPresent(forKey: .installationLocation) ?? installationLocation
		downloadLocation = try container.decodeIfPresent(forKey: .downloadLocation) ?? downloadLocation
		sortOrder = try container.decodeIfPresent(forKey: .sortOrder) ?? sortOrder
		infoVisibility = try container.decodeIfPresent(forKey: .infoVisibility) ?? infoVisibility
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(installationLocation, forKey: .installationLocation)
		try container.encodeIfPresent(downloadLocation, forKey: .downloadLocation)
		try container.encodeIfPresent(sortOrder, forKey: .sortOrder)
		try container.encodeIfPresent(infoVisibility, forKey: .infoVisibility)
	}
}

// MARK: - Constants

public extension AppSettings.Installations {
	static var defaultInstallationLocation: URL {
		URL.applicationDirectory.appending(path: "Unity", directoryHint: .isDirectory)
	}

	static var defaultDownloadLocation: URL {
		URL.cachesDirectory.appending(path: "Unity", directoryHint: .isDirectory)
	}
}
