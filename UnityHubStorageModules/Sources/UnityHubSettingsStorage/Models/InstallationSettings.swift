import Foundation
import UnityHubCommon

@Observable
public final class InstallationSettings {
	public var infoVisibility: InstallationInfoVisibility.Mask
	public var sortOrder: SortOrder

	public init() {
		infoVisibility = .all
		sortOrder = .forward
	}
}

// MARK: - Hashable

public extension InstallationSettings {
	func hash(into hasher: inout Hasher) {
		hasher.combine(infoVisibility)
		hasher.combine(sortOrder)
	}
}

// MARK: - Codable

/// - NOTE: use manual `Codable` implementation since values may change in the future.

public extension InstallationSettings {
	private enum CodingKeys: CodingKey {
		case infoVisibility
		case sortOrder
	}

	convenience init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		/// - NOTE: use `decodeIfPresent` to avoid issues when adding new settings

		infoVisibility = try container.decodeIfPresent(forKey: .infoVisibility) ?? infoVisibility
		sortOrder = try container.decodeIfPresent(forKey: .sortOrder) ?? sortOrder
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(infoVisibility, forKey: .infoVisibility)
		try container.encode(sortOrder, forKey: .sortOrder)
	}
}

// MARK: - SettingsFile

extension InstallationSettings: SettingsFile {
	public static let shared: InstallationSettings = InstallationSettings()

	public static let category: SettingsCategory = .installations
}
