import Foundation
import UnityHubCommon

@Observable
public final class LocationSettings {
	public var installationLocation: URL? { didSet { save() } }
	public var downloadLocation: URL? { didSet { save() } }
	public var officialHubLocation: URL? { didSet { save() } }

	public init() {
		installationLocation = nil
		downloadLocation = nil
		officialHubLocation = nil
	}
}

// MARK: - Hashable

public extension LocationSettings {
	func hash(into hasher: inout Hasher) {
		hasher.combine(installationLocation)
		hasher.combine(downloadLocation)
		hasher.combine(officialHubLocation)
	}
}

// MARK: - Codable

public extension LocationSettings {
	private enum CodingKeys: CodingKey {
		case installationLocation
		case downloadLocation
		case officialHubLocation
	}

	convenience init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		installationLocation = try container.decodeIfPresent(forKey: .installationLocation) ?? installationLocation
		downloadLocation = try container.decodeIfPresent(forKey: .downloadLocation) ?? downloadLocation
		officialHubLocation = try container.decodeIfPresent(forKey: .officialHubLocation) ?? officialHubLocation
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(installationLocation, forKey: .installationLocation)
		try container.encodeIfPresent(downloadLocation, forKey: .downloadLocation)
		try container.encodeIfPresent(officialHubLocation, forKey: .officialHubLocation)
	}
}

// MARK: - SettingsFile

extension LocationSettings: SettingsFile {
	public static let shared: LocationSettings = LocationSettings.load()

	public static let category: SettingsCategory = .locations
}
