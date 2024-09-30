import Combine
import Foundation
import UHStorage_Common
import UnityHubCommon

public struct LocationSettings {
	public var installationLocation: URL?
	public var downloadLocation: URL?
	public var officialHubLocation: URL?

	public init() {
		installationLocation = nil
		downloadLocation = nil
		officialHubLocation = nil
	}
}

// MARK: - Sendable

extension LocationSettings: Sendable { }

// MARK: - Equatable

extension LocationSettings: Equatable { }

// MARK: - Hashable

extension LocationSettings: Hashable { }

// MARK: - Codable

extension LocationSettings: Codable {
	private enum CodingKeys: CodingKey {
		case installationLocation
		case downloadLocation
		case officialHubLocation
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		installationLocation = try container.decodeIfPresent(forKey: .installationLocation) ?? installationLocation
		downloadLocation = try container.decodeIfPresent(forKey: .downloadLocation) ?? downloadLocation
		officialHubLocation = try container.decodeIfPresent(forKey: .officialHubLocation) ?? officialHubLocation
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(installationLocation, forKey: .installationLocation)
		try container.encodeIfPresent(downloadLocation, forKey: .downloadLocation)
		try container.encodeIfPresent(officialHubLocation, forKey: .officialHubLocation)
	}
}

// MARK: - SingletonFile

extension LocationSettings: SingletonFile {
	@ObservingCurrentValue
	public static var shared: Self = Self.read(sharedSubscriber) {
		didSet {
			shared.write()
		}
	}

	@MainActor
	static let sharedSubscriber: AnyCancellable = $shared.publisher
		.sink { newValue in newValue.write() }
}

// MARK: - SettingsFile

extension LocationSettings: SettingsFile {
	public static let category: SettingsCategory = .locations
}
