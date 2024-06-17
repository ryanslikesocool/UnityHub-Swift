import Foundation
import SerializationKit
import UserIcon

public struct ProjectMetadata {
	public var icon: UserIcon

	public init() {
		icon = .blank
	}

	public init(contentsOf url: URL) throws {
		let data = try Data(contentsOf: url)
		self = try Self.decoder.decode(Self.self, from: data)
	}
}

// MARK: - Hashable

extension ProjectMetadata: Hashable { }

// MARK: - Codable

extension ProjectMetadata: Codable {
	private enum CodingKeys: CodingKey {
		case icon
		case pinned
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

extension ProjectMetadata {
	static let fileName: String = ".openunityhub.json"

	static let decoder: JSONDecoder = JSONDecoder()

	static let encoder: JSONEncoder = {
		let encoder = JSONEncoder()
		encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
		return encoder
	}()
}
