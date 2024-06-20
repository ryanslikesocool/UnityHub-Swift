import Foundation
import OSLog
import SerializationKit
import UnityHubCommon

@Observable
public final class InstallationCache {
	public var installations: [InstallationMetadata]

	public var uniqueMajorVersions: [SemanticVersion.Integer] { Set(installations.compactMap(\.version?.major)).sorted() }

	public init() {
		installations = []
	}
}

// MARK: - Codable

extension InstallationCache: Codable {
	enum CodingKeys: CodingKey {
		case installations
	}

	public convenience init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		installations = try container.decodeIfPresent(forKey: .installations) ?? installations
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(installations, forKey: .installations)
	}
}

// MARK: - GlobalFile

extension InstallationCache: GlobalFile {
	public static let shared: InstallationCache = InstallationCache.load()

	public static let fileName: String = "installations.json"

	public static var fileURL: URL {
		URL.applicationSupportDirectory
			.appending(path: Bundle.main.bundleIdentifier!, directoryHint: .isDirectory)
			.appending(path: fileName, directoryHint: .notDirectory)
	}
}

// MARK: - Validation

extension InstallationCache {
	func validateInstallationURLConflict(_ url: URL) throws {
		if installations.contains(where: { $0.url == url }) {
			throw InstallationError.alreadyExists
		}
	}

	func validateInstallationContent(at url: URL) throws {
		let fileManager: FileManager = FileManager.default
		guard
			try url.isApplication(),
			fileManager.fileExists(at: url, appending: InstallationMetadata.infoPlistPath)
		else {
			throw InstallationError.invalid
		}
	}
}

// MARK: - Internal

private extension InstallationCache {
	func _addInstallation(at url: URL) {
		let installation = InstallationMetadata(url: url)
		installations.append(installation)
	}

	func _removeInstallation(at url: URL) {
		installations.removeAll(where: { $0.url == url })
	}
}

// MARK: -

public extension InstallationCache {
	subscript(url: URL) -> InstallationMetadata? {
		get { installations.first(where: { $0.url == url }) }
		set {
			guard let newValue else {
				preconditionFailure("Cannot remove object via subscript.")
			}
			guard let index = installations.firstIndex(where: { $0.url == url }) else {
				Logger.module.warning("Missing project at \(url.path(percentEncoded: false))")
				return
			}
			installations[index] = newValue

			save()
		}
	}

	func addInstallation(at url: URL) throws {
		try validateInstallationURLConflict(url)
		try validateInstallationContent(at: url)

		_addInstallation(at: url)

		save()
	}

	func removeInstallation(at url: URL) {
		_removeInstallation(at: url)

		save()
	}

	func changeInstallationURL(from oldURL: URL, to newURL: URL) throws {
		try validateInstallationContent(at: newURL)

		// TODO: improve edge case handling
		/// what if `newURL` contains a project, but actual project is different from `oldURL`?
		/// can we identify a project with a persistent ID?
		do {
			try validateInstallationURLConflict(newURL)
		} catch {
			/// if `newURL` is already occupied, don't add it
			return
		}

		_removeInstallation(at: oldURL)

		_addInstallation(at: newURL)

		save()
	}
}
