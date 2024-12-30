import Combine
import Foundation
import UnityHubStorageCommon
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

// MARK: - SingletonFileProtocol

extension LocationSettings: SingletonFileProtocol {
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

// MARK: - SettingsFileProtocol

extension LocationSettings: SettingsFileProtocol {
	public static let category: SettingsCategory = .locations
}

// MARK: - Constants

public extension LocationSettings {
	static let defaultInstallationLocation: URL = URL.applicationDirectory
		.appending(component: "Unity", directoryHint: .isDirectory)

	static let defaultDownloadLocation: URL = URL.cachesDirectory
		.appending(component: "Unity", directoryHint: .isDirectory)

	static let defaultOfficialHubLocation: URL = URL.applicationDirectory
		.appending(component: "Unity Hub.app", directoryHint: .notDirectory)
}
