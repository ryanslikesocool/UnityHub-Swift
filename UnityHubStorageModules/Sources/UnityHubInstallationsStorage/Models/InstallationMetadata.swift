import Foundation
import OSLog
import UnityHubCommon
import UnityHubSettingsStorage

public struct InstallationMetadata {
	public let url: URL

	var isInDefaultLocation: Bool {
		let defaultInstallationPath: String = Utility.Installation.getDefaultInstallationURL().path()
		return !url.path().starts(with: defaultInstallationPath)
	}

	public var version: UnityEditorVersion? {
		get throws { try Utility.Installation.getInfoPlist(appURL: url).bundleVersion }
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
