import Foundation

public struct InstallationMetadata {
	public let url: URL

	public private(set) var version: UnityEditorVersion?

	public init(url: URL) {
		self.url = url
	}
}

// MARK: - Hashable

extension InstallationMetadata: Hashable { }

// MARK: - Identifiable

extension InstallationMetadata: Identifiable {
	public var id: URL { url }
}

// MARK: - Codable

extension InstallationMetadata: Codable {
	private enum CodingKeys: CodingKey {
		case url
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let url: URL = try container.decode(forKey: .url)

		self.init(url: url)

		if let infoPlist = try? Self.retrieveInfoPlist(from: url) {
			version = infoPlist.bundleVersion
		}
	}
}

// MARK: - Constants

extension InstallationMetadata {
	/// - Remark: This path is relative to `Unity.app`.
	static let infoPlistPath: String = "Contents/Info.plist"

	/// - Remark: This path is relative to the directory containing `Unity.app`.
	static let modulesJSONPath: String = "modules.json"

	/// - Remark: This path is relative to the directory containing `Unity.app`.
	static let bugReporterPath: String = "Unity Bug Reporter.app"

	static let bundleIdentifierValue: String = "com.unity3d.UnityEditor5.x"
}

// MARK: -

private extension InstallationMetadata {
	static func retrieveInfoPlist(from url: URL) throws -> SimpleInfoPlist {
		let url = url.appending(path: infoPlistPath, directoryHint: .notDirectory)
		let data = try Data(contentsOf: url)
		return try PropertyListDecoder.shared.decode(SimpleInfoPlist.self, from: data)
	}
}

public extension InstallationMetadata {
	var exists: Bool {
		(try? url.checkResourceIsReachable()) ?? false
	}
}
