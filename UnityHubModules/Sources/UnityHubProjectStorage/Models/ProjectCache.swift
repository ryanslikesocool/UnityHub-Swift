import Foundation
import OSLog
import SerializationKit
import UnityHubCommon
import UnityHubInstallationsStorage

@Observable
public final class ProjectCache {
	public var projects: [ProjectMetadata]

	public var projectEditorVersions: [UnityEditorVersion] {
		Set(projects.compactMap(\.editorVersion)).sorted()
	}

	public init() {
		projects = []
	}
}

// MARK: - Codable

extension ProjectCache: Codable {
	private enum CodingKeys: CodingKey {
		case projects
	}

	public convenience init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		projects = try container.decodeIfPresent(forKey: .projects) ?? projects
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(projects.sorted(by: \.url), forKey: .projects)
	}
}

// MARK: - GlobalFile

extension ProjectCache: GlobalFile {
	public static let shared: ProjectCache = ProjectCache.load()

	public static let fileName: String = "projects.plist"

	public static var fileURL: URL {
		URL.applicationSupportDirectory
			.appending(component: Bundle.main.bundleIdentifier!, directoryHint: .isDirectory)
			.appending(component: fileName, directoryHint: .notDirectory)
	}
}

// MARK: - Validation

public extension ProjectCache {
	func validateProjectURLConflict(_ url: URL) throws {
		if projects.contains(where: { $0.url == url }) {
			throw ProjectError.alreadyExists
		}
	}

	func validateProjectContent(at url: URL) throws {
		let fileManager: FileManager = FileManager.default
		/// don't validate `/Packages` since the package manager was only introduced "recently"
		guard
			try url.isDirectory(),
			fileManager.directoryExists(at: url),
			fileManager.directoryExists(at: url, appending: "Assets"),
			fileManager.directoryExists(at: url, appending: "ProjectSettings")
		else {
			throw ProjectError.invalid
		}
	}
}

// MARK: - Internal

private extension ProjectCache {
	func _addProject(at url: URL, transform: ((inout ProjectMetadata) -> Void)? = nil) {
		var project = ProjectMetadata(url: url)
		transform?(&project)
		projects.append(project)
	}

	func _removeProject(at url: URL) {
		projects.removeAll(where: { $0.url == url })
	}
}

// MARK: -

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

			save()
		}
	}

	func addProject(at url: URL) throws {
		try validateProjectURLConflict(url)
		try validateProjectContent(at: url)

		_addProject(at: url)

		save()
	}

	func removeProject(at url: URL) {
		_removeProject(at: url)

		save()
	}

	func changeProjectURL(from oldURL: URL, to newURL: URL) throws {
		guard let oldProject = self[oldURL] else {
			throw ProjectError.missing(oldURL)
		}

		try validateProjectContent(at: newURL)

		// TODO: improve edge case handling
		/// what if `newURL` contains a project, but actual project is different from `oldURL`?
		/// can we identify a project with a persistent ID?
		do {
			try validateProjectURLConflict(newURL)
		} catch {
			/// if `newURL` is already occupied, don't add it
			return
		}

		_removeProject(at: oldURL)

		_addProject(at: newURL) { newProject in
			newProject.pinned = oldProject.pinned
			newProject.lastOpened = oldProject.lastOpened
		}

		save()
	}

	func openProject(at url: URL) throws {
		try validateProjectContent(at: url)

		self[url]?.lastOpened = .now

		print("\(Self.self).\(#function) is not implemented")

		save()
	}
}