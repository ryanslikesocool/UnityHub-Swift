import Foundation
import SerializationKit
import UnityHubCommon

public extension AppSettings {
	struct Projects: AppSettingsCategoryStorage {
		public static let category: AppSettingsCategory = .projects

		public var infoVisibility: ProjectInfoVisibility.Mask
		public var sortCriteria: ProjectSortCriteria
		public var sortOrder: SortOrder

		init() {
			infoVisibility = .all
			sortCriteria = .lastOpened
			sortOrder = .reverse
		}
	}
}

// MARK: - Codable

public extension AppSettings.Projects {
	private enum CodingKeys: CodingKey {
		case infoVisibility
		case sortCriteria
		case sortOrder
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		infoVisibility = try container.decodeIfPresent(forKey: .infoVisibility) ?? infoVisibility
		sortCriteria = try container.decodeIfPresent(forKey: .sortCriteria) ?? sortCriteria
		sortOrder = try container.decodeIfPresent(forKey: .sortOrder) ?? sortOrder
	}

	func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(infoVisibility, forKey: .infoVisibility)
		try container.encode(sortCriteria, forKey: .sortCriteria)
		try container.encode(sortOrder, forKey: .sortOrder)
	}
}
