import Foundation
import OSLog
import UnityHubCommon

// MARK: - Internal

extension InstallationCache {
	mutating func _add(at url: URL) {
		let installation = InstallationMetadata(url: url)
		installations.append(installation)
	}

	mutating func _remove(at url: URL) {
		installations.removeAll { item in item.url == url }
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

			write()
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

			write()
		}
	}
}

// MARK: -

public extension InstallationCache {
	mutating func add(at url: borrowing URL) throws {
		try validateInstallationURLConflict(url)
		try Utility.Application.Unity.validateInstallation(at: url)

		_add(at: url)

		write()
	}

	mutating func remove(at url: borrowing URL) {
		_remove(at: url)

		write()
	}

	mutating func changeURL(from oldURL: borrowing URL, to newURL: borrowing URL) throws {
		try Utility.Application.Unity.validateInstallation(at: newURL)

		// TODO: improve edge case handling
		/// what if `newURL` contains an editor, but actual editor is different from `oldURL`?
		/// can we identify an editor with a persistent ID?
		/// `UnityBuildNumber` from Info.plist, maybe?
		do {
			try validateInstallationURLConflict(newURL)
		} catch {
			/// if `newURL` is already occupied, don't add it
			return
		}

		_remove(at: oldURL)

		_add(at: newURL)

		write()
	}

	func get(for version: UnityEditorVersion) -> InstallationMetadata? {
		installations.first { installation in
			(try? installation.version) == version
		}
	}

	func contains(_ version: UnityEditorVersion) -> Bool {
		installations.contains { installation in
			(try? installation.version) == version
		}
	}

	func contains(_ version: UnityEditorVersion?) -> Bool {
		guard let version else {
			return false
		}
		return contains(version)
	}

	func contains(_ url: URL) -> Bool {
		installations.contains(where: { $0.url == url })
	}
}
