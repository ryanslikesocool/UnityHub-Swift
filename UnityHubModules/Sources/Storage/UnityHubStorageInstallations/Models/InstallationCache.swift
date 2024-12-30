import Combine
import Foundation
import OSLog
import UnityHubStorageCommon
import UnityHubStorageSettings
import UnityHubCommon

@MainActor
public struct InstallationCache {
	public var installations: [InstallationMetadata]

	public var uniqueMajorVersions: [SemanticVersion.Integer] { Set(
		installations.compactMap { (try? $0.version)?.major }
	).sorted() }

	public nonisolated init() {
		installations = []
	}
}

// MARK: - Sendable

// extension InstallationCache: Sendable { }

// MARK: - Equatable

extension InstallationCache: Equatable { }

// MARK: - Hashable

extension InstallationCache: Hashable { }

// MARK: - Codable

extension InstallationCache: @preconcurrency Codable {
	public init(from decoder: any Decoder) throws {
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

// MARK: - SingletonFileProtocol

extension InstallationCache: SingletonFileProtocol {
	@ObservingCurrentValue
	public static var shared: Self = Self.read(sharedSubscriber) {
		didSet {
			shared.write()
		}
	}

	@MainActor
	static let sharedSubscriber: AnyCancellable = $shared.publisher
		.sink { newValue in newValue.write() }
}

// MARK: - CacheFileProtocol

extension InstallationCache: CacheFileProtocol {
	public nonisolated static let category: CacheCategory = .installations
}

// MARK: - Validation

extension InstallationCache {
	func validateInstallationURLConflict(_ url: borrowing URL) throws {
		if contains(url) {
			throw InstallationError.alreadyExists
		}
	}

	public mutating func validateInstallations() {
		installations = installations.filter(by: \.isInDefaultLocation, equals: true)
		getInstallationsFromDefaultLocation()
	}
}

// MARK: -

public extension InstallationCache {
	@MainActor
	mutating func getInstallationsFromDefaultLocation() {
		let location: URL = LocationSettings.shared.installationLocation ?? LocationSettings.defaultInstallationLocation
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
