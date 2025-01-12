import Combine
import Foundation

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

// MARK: - CreditProtocol

extension Contributor: CreditProtocol {
	typealias ItemView = ContributorCreditItem

	static let fileName: String = "Contributors"
	static let fileExtension: String = "json"

	static var topLevelDecoder: JSONDecoder { JSONDecoder.shared }
	static var sortComparator: (any SortComparator<Contributor>)? {
		KeyPathComparator<Self>(\.name)
	}
	static let modelKeyPath: ReferenceWritableKeyPath<AboutSceneModel, [Self]> = \.contributors
}
