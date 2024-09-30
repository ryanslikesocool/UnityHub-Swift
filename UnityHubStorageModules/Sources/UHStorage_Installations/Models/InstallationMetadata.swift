import Foundation
import OSLog
import UnityHubCommon
import UHStorage_Settings

public struct InstallationMetadata {
	public let url: URL

	var isInDefaultLocation: Bool {
		let defaultInstallationPath: String = Utility.Application.Unity.defaultInstallationURL.path()
		return !url.path().starts(with: defaultInstallationPath)
	}

	public var version: UnityEditorVersion {
		get throws {
			let bundleVersionString: String = try Utility.Application.getBundleVersion(from: url)
			return try UnityEditorVersion(bundleVersionString)
		}
	}

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
	}
}

// MARK: -

public extension InstallationMetadata {
	var applicationExists: Bool {
		FileManager.default.directoryExists(at: url)
	}
}
