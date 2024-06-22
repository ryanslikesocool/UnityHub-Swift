import Foundation
import UnityHubCommon

extension ProjectCache {
	func validateProjectURLConflict(_ url: URL) throws {
		if projects.contains(where: { $0.url == url }) {
			throw ProjectError.alreadyExists
		}
	}

	static func validateProjectContent(at url: URL) throws {
		let fileManager: FileManager = FileManager.default
		/// - Note: Don't validate `/Packages` since the package manager was only introduced "recently".
		guard
			fileManager.directoryExists(at: url),
			fileManager.directoryExists(at: url, appending: "Assets"),
			fileManager.directoryExists(at: url, appending: "ProjectSettings")
		else {
			throw ProjectError.invalid
		}
	}
}
