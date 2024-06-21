import Foundation
import UserIcon

public extension ProjectMetadata {
	/// Metadata for a project, stored within the project.
	struct Embedded {
		public var icon: UserIcon

		init() {
			icon = .blank
		}
	}
}

// MARK: - Hashable

extension ProjectMetadata.Embedded: Hashable { }

// MARK: - Codable

extension ProjectMetadata.Embedded: Codable {
	private enum CodingKeys: CodingKey {
		case icon
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		icon = try container.decodeIfPresent(forKey: .icon) ?? icon
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(icon, forKey: .icon)
	}
}

// MARK: - Constants

extension ProjectMetadata.Embedded {
	static let fileName: String = ".developedwithlove.unityhub.json"
}
