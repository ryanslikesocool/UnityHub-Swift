import Foundation
import SwiftUI

struct Contributor {
	public let name: String
	public let personalURL: URL?
	public let githubURL: URL?

	private init(
		name: String,
		personalURL: URL?,
		githubURL: URL?
	) {
		self.name = name
		self.personalURL = personalURL
		self.githubURL = githubURL
	}
}

// MARK: - Sendable

extension Contributor: Sendable { }

// MARK: - Decodable

extension Contributor: Decodable { }

// MARK: - CreditItem

extension Contributor: CreditItem {
	static var label: Text { Text(.credits.group.contributors) }

	static var fileURL: URL? {
		Bundle.main.url(forResource: "Contributors", withExtension: "json")
	}

	static var topLevelDecoder: JSONDecoder { JSONDecoder.shared }
	static var sortComparator: (any SortComparator<Contributor>)? {
		KeyPathComparator<Self>(\.name)
	}

	static let modelKeyPath: ReferenceWritableKeyPath<AboutSceneModel, [Self]> = \.contributors
}
