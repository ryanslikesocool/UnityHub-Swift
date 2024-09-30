import Foundation
import OSLog
import UnityHubCommon

// MARK: - Private

private extension ProjectCache {
	mutating func _add(at url: URL, transform: ((inout ProjectMetadata) -> Void)? = nil) {
		var project = ProjectMetadata(url: url)
		transform?(&project)
		projects.append(project)
	}

	mutating func _remove(at url: URL) {
		projects.removeAll(where: { $0.url == url })
	}
}

// MARK: - Subscript

public extension ProjectCache {
	subscript(url: URL) -> ProjectMetadata? {
		get { projects.first(where: { $0.url == url }) }
		set {
			guard let newValue else {
				preconditionFailure("Cannot remove object via subscript.")
			}
			guard let index = projects.firstIndex(where: { $0.url == url }) else {
				Logger.module.warning("Missing project at \(url.path(percentEncoded: false))")
				return
			}
			projects[index] = newValue

			write()
		}
	}
}

// MARK: -

public extension ProjectCache {
	mutating func add(at url: URL) throws {
		try validateProjectURLConflict(url)
		try Self.validateProjectContent(at: url)

		_add(at: url)

		write()
	}

	mutating func remove(at url: URL) {
		_remove(at: url)

		write()
	}

	mutating func changeURL(from oldURL: URL, to newURL: URL) throws {
		guard let oldProject = self[oldURL] else {
			throw ProjectError.missing(oldURL)
		}

		try Self.validateProjectContent(at: newURL)

		// TODO: improve edge case handling
		/// what if `newURL` contains a project, but actual project is different from `oldURL`?
		/// can we identify a project with a persistent ID?
		do {
			try validateProjectURLConflict(newURL)
		} catch {
			/// if `newURL` is already occupied, don't add it
			return
		}

		_remove(at: oldURL)

		_add(at: newURL) { newProject in
			newProject.pinned = oldProject.pinned
			newProject.lastOpened = oldProject.lastOpened
		}

		write()
	}
}
