import Foundation

public struct ProjectUserMetadata {
	public let url: URL
	public var pinned: Bool
	public var lastOpened: Date?

	public var name: String { url.lastPathComponent }

	public init(url: URL) {
		self.url = url
		self.pinned = false
		self.lastOpened = nil
	}
}

// MARK: - Hashable

extension ProjectUserMetadata: Hashable { }

// MARK: - Identifiable

extension ProjectUserMetadata: Identifiable { 
	public var id: URL { url }
}

// MARK: - Codable

extension ProjectUserMetadata: Codable { 
//	enum CodingKeys: CodingKey {
//		case url
//		case pinned
//		case lastOpened
//	}
//
//	public init(from decoder: any Decoder) throws {
//		<#code#>
//	}
//
//	public func encode(to encoder: any Encoder) throws {
//		<#code#>
//	}
}

// MARK: -

extension ProjectUserMetadata {
	func withNewURL(_ url: URL) -> Self {
		var result = Self(url: url)
		result.pinned = pinned
		result.lastOpened = lastOpened
		return result
	}
}
