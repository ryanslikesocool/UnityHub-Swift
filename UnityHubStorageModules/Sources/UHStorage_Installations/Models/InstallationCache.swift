import Foundation
import OSLog
import UnityHubCommon
import UHStorage_Settings
import UHStorage_Common

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

		getInstallationsFromDefaultLocation()
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()

		try container.encode(
			installations.filter(by: \.isInDefaultLocation, equals: false)
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
	func validateInstallationURLConflict(_ url: borrowing URL) throws {
		if contains(url) {
			throw InstallationError.alreadyExists
		}
	}

	public func validateInstallations() {
		installations = installations.filter(by: \.isInDefaultLocation, equals: true)
		getInstallationsFromDefaultLocation()
	}
}

// MARK: -

public extension InstallationCache {
	func getInstallationsFromDefaultLocation() {
		let location: URL = LocationSettings.shared.installationLocation ?? Constant.Settings.Location.defaultInstallationLocation
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

		let applicationURLs: [URL] = items.compactMap { item -> URL? in
			guard (try? item.checkIsDirectory()) == true else {
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

			return subitems.first { url in
				(try? url.checkIsApplication()) == true
					&& (try? Utility.Application.Unity.validateInstallation(at: url)) == true
					&& !contains(url)
			}
		}

		for url in applicationURLs where !contains(url) {
			_add(at: url)
		}
	}
}
