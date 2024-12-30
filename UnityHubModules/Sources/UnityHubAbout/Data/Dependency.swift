import Foundation

struct Dependency {
	public let title: String
	public let url: URL
	public let licenseURL: URL?

	private init(
		title: String,
		url: URL,
		licenseURL: URL?
	) {
		self.title = title
		self.url = url
		self.licenseURL = licenseURL
	}
}

// MARK: - Sendable

extension Dependency: Sendable { }

// MARK: - Decodable

extension Dependency: Decodable { }

// MARK: - Acknowledgement

extension Dependency: Acknowledgement {
	typealias ItemView = DependencyAcknowledgementItem

	static let fileName: String = "Dependencies"
	static let fileExtension: String = "json"
	static var decoder: JSONDecoder { JSONDecoder.shared }
	static var sortComparator: (any SortComparator<Dependency>)? {
		KeyPathComparator<Self>(\.title)
	}
	static let modelKeyPath: ReferenceWritableKeyPath<AboutSceneModel, [Self]> = \.dependencies
}