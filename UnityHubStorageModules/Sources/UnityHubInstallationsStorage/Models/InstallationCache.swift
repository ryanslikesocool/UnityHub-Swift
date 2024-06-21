import Foundation
import OSLog
import UnityHubCommon
import UnityHubSettingsStorage
import UnityHubStorageCommon

@Observable
public final class InstallationCache {
	public var installations: [InstallationMetadata]

	public var uniqueMajorVersions: [SemanticVersion.Integer] { Set(
		installations.compactMap { (try? $0.version)?.major }
	).sorted() }

	public init() {
		installations = []
	}
}

// MARK: - Hashable

public extension InstallationCache {
	func hash(into hasher: inout Hasher) {
		hasher.combine(installations)
	}
}

// MARK: - Codable

extension InstallationCache: Codable {
	public convenience init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()

		self.init()

		installations = try container.decode()
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()

		let defaultInstallationLocationPath: String = (LocationSettings.shared.installationLocation ?? Constant.Settings.Locations.defaultInstallationLocation)
			.path()

		try container.encode(
			installations.filter { installation in
				!installation.url.path().starts(with: defaultInstallationLocationPath)
			}
		)
	}
}

// MARK: - GlobalFile

extension InstallationCache: CacheFile {
	public static let shared: InstallationCache = InstallationCache.load()

	public static let category: CacheCategory = .installations
}

// MARK: - Validation

extension InstallationCache {
	func installationExists(at url: URL) -> Bool {
		installations.contains(where: { $0.url == url })
	}

	func validateInstallationURLConflict(_ url: URL) throws {
		if installationExists(at: url) {
			throw InstallationError.alreadyExists
		}
	}
}

// MARK: - Private

private extension InstallationCache {
	func _add(at url: URL) {
		let installation = InstallationMetadata(url: url)
		installations.append(installation)
	}

	func _remove(at url: URL) {
		installations.removeAll(where: { $0.url == url })
	}

	func readFromDefaultLocation() {
		let location: URL = LocationSettings.shared.installationLocation ?? Constant.Settings.Locations.defaultInstallationLocation
		let fileManager: FileManager = .default

		let items: [URL]
		do {
			items = try fileManager.contentsOfDirectory(at: location)
		} catch {
			Logger.module.error("""
			Failed to read contents of \(location.path(percentEncoded: false)):
			\(error.localizedDescription)
			""")
			return
		}

		let applicationURLs: [URL] = items.compactMap { item in
			guard (try? item.isDirectory()) == true else {
				return nil
			}

			let subitems: [URL]
			do {
				subitems = try fileManager.contentsOfDirectory(at: item)
			} catch {
				Logger.module.warning("""
				Failed to read contents of \(item.path(percentEncoded: false)):
				\(error.localizedDescription)
				""")
				return nil
			}

			return subitems.first(where: { url in
				(try? url.isApplication()) == true
					&& (try? Utility.Installation.validateInstallation(appURL: url)) == true
					&& !installationExists(at: url)
			})
		}

		for url in applicationURLs {
			_add(at: url)
		}
	}
}

// MARK: - Subscript

public extension InstallationCache {
	subscript(url: URL) -> InstallationMetadata? {
		get { installations.first(where: { $0.url == url }) }
		set {
			guard let newValue else {
				preconditionFailure("Cannot remove object via subscript.")
			}
			guard let index = installations.firstIndex(where: { $0.url == url }) else {
				Logger.module.warning("Missing installation at \(url.path(percentEncoded: false)).")
				return
			}
			installations[index] = newValue

			save()
		}
	}

	subscript(version: UnityEditorVersion) -> InstallationMetadata? {
		get { installations.first(where: { (try? $0.version) == version }) }
		set {
			guard let newValue else {
				preconditionFailure("Cannot remove object via subscript.")
			}
			guard let index = installations.firstIndex(where: { (try? $0.version) == version }) else {
				Logger.module.warning("Missing installation with version \(version).")
				return
			}
			installations[index] = newValue

			save()
		}
	}
}

// MARK: -

public extension InstallationCache {
	func add(at url: URL) throws {
		try validateInstallationURLConflict(url)
		try Utility.Installation.validateInstallation(appURL: url)

		_add(at: url)

		save()
	}

	func remove(at url: URL) {
		_remove(at: url)

		save()
	}

	func changeURL(from oldURL: URL, to newURL: URL) throws {
		try Utility.Installation.validateInstallation(appURL: newURL)

		// TODO: improve edge case handling
		/// what if `newURL` contains a project, but actual project is different from `oldURL`?
		/// can we identify a project with a persistent ID?
		do {
			try validateInstallationURLConflict(newURL)
		} catch {
			/// if `newURL` is already occupied, don't add it
			return
		}

		_remove(at: oldURL)

		_add(at: newURL)

		save()
	}

	func get(for version: UnityEditorVersion) -> InstallationMetadata? {
		installations.first(where: { (try? $0.version) == version })
	}
}
