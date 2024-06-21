import Foundation
import UnityHubCommon

@Observable
public final class ProjectSettings {
	public var infoVisibility: ProjectInfoVisibility.Mask
	public var sortCriteria: ProjectSortCriteria
	public var sortOrder: SortOrder

	public init() {
		infoVisibility = .all
		sortCriteria = .lastOpened
		sortOrder = .forward
	}
}

// MARK: - Hashable

public extension ProjectSettings {
	func hash(into hasher: inout Hasher) {
		hasher.combine(infoVisibility)
		hasher.combine(sortCriteria)
		hasher.combine(sortOrder)
	}
}

// MARK: - Codable

/// - NOTE: use manual `Codable` implementation since values may change in the future.

public extension ProjectSettings {
	private enum CodingKeys: CodingKey {
		case infoVisibility
		case sortCriteria
		case sortOrder
	}

	convenience init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		/// - NOTE: use `decodeIfPresent` to avoid issues when adding new settings

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

// MARK: - SettingsFile

extension ProjectSettings: SettingsFile {
	public static let shared: ProjectSettings = ProjectSettings.load()

	public static let category: SettingsCategory = .projects
}
