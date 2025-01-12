import Foundation

struct Acknowledgement {
	public let title: String
	public let projectURL: URL
	public let licenseURL: URL?

	private init(
		title: String,
		projectURL: URL,
		licenseURL: URL?
	) {
		self.title = title
		self.projectURL = projectURL
		self.licenseURL = licenseURL
	}
}

// MARK: - Sendable

extension Acknowledgement: Sendable { }

// MARK: - Decodable

extension Acknowledgement: Decodable {
	enum CodingKeys: CodingKey {
		case title
		case projectURL
		case licenseURL
		case licensePath
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		title = try container.decode(String.self, forKey: .title)
		projectURL = try container.decode(URL.self, forKey: .projectURL)

		licenseURL = if let decodedLicenseURL = try container.decodeIfPresent(URL.self, forKey: .licenseURL) {
			decodedLicenseURL
		} else if let decodedLicensePath = try container.decodeIfPresent(String.self, forKey: .licensePath) {
			projectURL.appending(path: decodedLicensePath)
		} else {
			nil
		}
	}
}

// MARK: - CreditProtocol

extension Acknowledgement: CreditProtocol {
	typealias ItemView = AcknowledgementCreditItem

	static let fileName: String = "Acknowledgements"
	static let fileExtension: String = "json"

	static var topLevelDecoder: JSONDecoder { JSONDecoder.shared }
	static var sortComparator: (any SortComparator<Acknowledgement>)? {
		KeyPathComparator<Self>(\.title)
	}

	static let modelKeyPath: ReferenceWritableKeyPath<AboutSceneModel, [Self]> = \.acknowledgements
}
