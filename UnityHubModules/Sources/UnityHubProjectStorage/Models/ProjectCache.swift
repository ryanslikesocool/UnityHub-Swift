import Foundation
import OSLog
import SerializationKit
import UnityHubCommon
import UnityHubInstallationsStorage

@Observable
public final class ProjectCache: GlobalFile {
	public static let shared: ProjectCache = ProjectCache.load()

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

// MARK: - Constants

public extension ProjectCache {
	static let fileName: String = "projects.plist"

	static var fileURL: URL {
		URL.applicationSupportDirectory
			.appending(component: Bundle.main.bundleIdentifier!, directoryHint: .isDirectory)
			.appending(component: fileName, directoryHint: .notDirectory)
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
		try validateProjectURLAvailable(url)
		try validateProjectIsValid(at: url)

		let project = ProjectMetadata(url: url)
		projects.append(project)

		save()
	}

	func removeProject(at url: URL) {
		projects.removeAll(where: { $0.url == url })

		save()
	}

	func changeProjectURL(from oldURL: URL, to newURL: URL) throws {
		guard let oldProject = self[oldURL] else {
			throw ProjectError.missing(oldURL)
		}

		try validateProjectIsValid(at: newURL)

		// TODO: improve edge case handling
		/// what if `newURL` contains a project, but actual project is different from `oldURL`?
		/// can we identify a project with a persistent ID?
		do {
			try validateProjectURLAvailable(newURL)
		} catch {
			/// if `newURL` is already occupied, don't add it
			return
		}

		removeProject(at: oldURL)

		/// don't use ``add(projectAt:)``.  we don't want to perform validation steps again.
		var newProject = ProjectMetadata(url: newURL)
		newProject.pinned = oldProject.pinned
		newProject.lastOpened = oldProject.lastOpened
		projects.append(newProject)

		save()
	}

	func openProject(at url: URL) throws {
		try validateProjectIsValid(at: url)

		print("\(Self.self).\(#function) is not implemented")
	}

	func validateProjectURLAvailable(_ url: URL) throws {
		if projects.contains(where: { $0.url == url }) {
			throw ProjectError.alreadyExists
		}
	}

	func validateProjectIsValid(at url: URL) throws {
		let fileManager: FileManager = FileManager.default
		guard
			try url.isDirectoryAndReachable(),
			fileManager.directoryExists(at: url),
			fileManager.directoryExists(at: url, appending: "Assets"),
			fileManager.directoryExists(at: url, appending: "Packages"),
			fileManager.directoryExists(at: url, appending: "ProjectSettings")
		else {
			throw ProjectError.invalid
		}
	}
}
