import Foundation
import OSLog
import UnityHubCommon
import UnityHubInstallationsStorage
import UnityHubStorageCommon

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

// MARK: - Hashable

public extension ProjectCache {
	func hash(into hasher: inout Hasher) {
		hasher.combine(projects)
	}
}

// MARK: - Codable

extension ProjectCache: Codable {
	public convenience init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()

		self.init()

		projects = try container.decode()
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()

		try container.encode(projects.sorted(by: \.url))
	}
}

// MARK: - GlobalFile

extension ProjectCache: CacheFile {
	public static let shared: ProjectCache = ProjectCache.load()

	public static let category: CacheCategory = .projects
}

// MARK: - Validation

public extension ProjectCache {
	func validateProjectURLConflict(_ url: URL) throws {
		if projects.contains(where: { $0.url == url }) {
			throw ProjectError.alreadyExists
		}
	}

	static func validateProjectContent(at url: URL) throws {
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
		try Self.validateProjectContent(at: url)

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

		_removeProject(at: oldURL)

		_addProject(at: newURL) { newProject in
			newProject.pinned = oldProject.pinned
			newProject.lastOpened = oldProject.lastOpened
		}

		save()
	}

	func openProject(at url: URL, with someVersion: UnityEditorVersion?) throws {
		let version: UnityEditorVersion = try unwrapVersion()

		try Self.validateProjectContent(at: url)

		guard var installation = InstallationCache.shared[version] else {
			throw InstallationError.missingInstallationForVersion(version)
		}
		try InstallationCache.validateInstallationContent(at: installation.url)
		installation.validateLazyData()
		InstallationCache.shared[version] = installation

		let installationPath: String = installation.executableURL.path(percentEncoded: true)
		let arguments: String = "-projectPath"
		let projectPath: String = url.path(percentEncoded: true)

		let command: String = "\(installationPath) \(arguments) \(projectPath)"
			.replacingOccurrences(of: "%20", with: #"\ "#)

		Task {
			do {
				try shell(command)
			} catch {
				throw ShellError(error)
			}

			await MainActor.run {
				self[url]?.lastOpened = .now

				save()
			}
		}

		func unwrapVersion() throws -> UnityEditorVersion {
			if let someVersion {
				return someVersion
			} else {
				guard let project = self[url] else {
					throw ProjectError.missing(url)
				}
				guard let projectEditorVersion = project.editorVersion else {
					throw ProjectError.unknownEditorVersion
				}
				return projectEditorVersion
			}
		}
	}
}
