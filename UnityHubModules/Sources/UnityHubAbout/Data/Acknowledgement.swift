import Foundation

struct Acknowledgement {
	public let title: String
	public let url: URL

	private init(
		title: String,
		url: URL
	) {
		self.title = title
		self.url = url
	}
}

// MARK: - Sendable

extension Acknowledgement: Sendable { }

// MARK: - Decodable

extension Acknowledgement: Decodable { }

// MARK: -

extension [Acknowledgement] {
	static func load(from bundle: Bundle = Bundle.main) throws -> Self {
		guard let resourceURL = bundle.url(forResource: "Acknowledgements", withExtension: "json") else {
			throw CocoaError(.fileReadNoSuchFile)
		}
		let data = try Data(contentsOf: resourceURL)
		let result = try JSONDecoder.shared.decode(Self.self, from: data)

		return result
	}
}