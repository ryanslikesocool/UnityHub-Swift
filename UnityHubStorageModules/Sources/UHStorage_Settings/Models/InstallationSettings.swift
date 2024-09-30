import Combine
import Foundation
import UHStorage_Common
import UnityHubCommon

public struct InstallationSettings {
	public var infoVisibility: InstallationInfoVisibility.Mask
	public var sortOrder: SortOrder

	public init() {
		infoVisibility = .all
		sortOrder = .forward
	}
}

// MARK: - Sendable

extension InstallationSettings: Sendable { }

// MARK: - Equatable

extension InstallationSettings: Equatable { }

// MARK: - Hashable

extension InstallationSettings: Hashable { }

// MARK: - Codable

/// - NOTE: use manual `Codable` implementation since values may change in the future.

extension InstallationSettings: Codable {
	private enum CodingKeys: CodingKey {
		case infoVisibility
		case sortOrder
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		/// - NOTE: use `decodeIfPresent` to avoid issues when adding new settings

		infoVisibility = try container.decodeIfPresent(forKey: .infoVisibility) ?? infoVisibility
		sortOrder = try container.decodeIfPresent(forKey: .sortOrder) ?? sortOrder
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(infoVisibility, forKey: .infoVisibility)
		try container.encode(sortOrder, forKey: .sortOrder)
	}
}

// MARK: - SingletonFile

extension InstallationSettings: SingletonFile {
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

extension InstallationSettings: SettingsFile {
	public static let category: SettingsCategory = .installations
}
