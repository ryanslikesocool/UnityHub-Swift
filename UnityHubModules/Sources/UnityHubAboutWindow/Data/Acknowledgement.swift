import Foundation
import SwiftUI

struct Acknowledgement {
	public let name: String
	public let projectURL: URL
	public let licenseURL: URL?

	private init(
		name: String,
		projectURL: URL,
		licenseURL: URL?
	) {
		self.name = name
		self.projectURL = projectURL
		self.licenseURL = licenseURL
	}
}

// MARK: - Sendable

extension Acknowledgement: Sendable { }

// MARK: - Decodable

extension Acknowledgement: Decodable {
	enum CodingKeys: CodingKey {
		case name
		case projectURL
		case licenseURL
		case licensePath
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		name = try container.decode(String.self, forKey: .name)
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

// MARK: - CreditItem

extension Acknowledgement: CreditItem {
	static var label: Text { Text(.credits.group.acknowledgements) }

	static var fileURL: URL? {
		Bundle.main.url(forResource: "Acknowledgements", withExtension: "json")
	}

	static var topLevelDecoder: JSONDecoder { JSONDecoder.shared }
	static var sortComparator: (any SortComparator<Acknowledgement>)? {
		KeyPathComparator<Self>(\.name)
	}

	static let modelKeyPath: ReferenceWritableKeyPath<AboutSceneModel, [Self]> = \.acknowledgements
}
