import Combine
import Foundation
import UHStorage_Common
import UnityHubCommon

public struct ProjectSettings {
	public var infoVisibility: ProjectInfoVisibility.Mask
	public var sortCriteria: ProjectSortCriteria
	public var sortOrder: SortOrder

	public init() {
		infoVisibility = .all
		sortCriteria = .lastOpened
		sortOrder = .forward
	}
}

// MARK: - Sendable

extension ProjectSettings: Sendable { }

// MARK: - Equatable

extension ProjectSettings: Equatable { }

// MARK: - Hashable

extension ProjectSettings: Hashable { }

// MARK: - Codable

/// - NOTE: use manual `Codable` implementation since values may change in the future.

extension ProjectSettings: Codable {
	private enum CodingKeys: CodingKey {
		case infoVisibility
		case sortCriteria
		case sortOrder
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		/// - NOTE: use `decodeIfPresent` to avoid issues when adding new settings

		infoVisibility = try container.decodeIfPresent(forKey: .infoVisibility) ?? infoVisibility
		sortCriteria = try container.decodeIfPresent(forKey: .sortCriteria) ?? sortCriteria
		sortOrder = try container.decodeIfPresent(forKey: .sortOrder) ?? sortOrder
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(infoVisibility, forKey: .infoVisibility)
		try container.encode(sortCriteria, forKey: .sortCriteria)
		try container.encode(sortOrder, forKey: .sortOrder)
	}
}

// MARK: - SingletonFile

extension ProjectSettings: SingletonFile {
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

extension ProjectSettings: SettingsFile {
	public static let category: SettingsCategory = .projects
}
