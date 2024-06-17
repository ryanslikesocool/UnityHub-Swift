import Foundation
import OSLog
import SerializationKit
import UnityHubCommon

@Observable
public final class ProjectCache: GlobalFile {
	public static let shared: ProjectCache = ProjectCache.load()

	public var projects: [ProjectMetadata] { didSet { save() } }

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
	static let fileName: String = "Projects.plist"

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
				Logger.module.warning("Missing project with URL \(url.path(percentEncoded: false))")
				return
			}
			projects[index] = newValue
		}
	}

	func addProject(at url: URL) throws {
		guard !projects.contains(where: { $0.url == url }) else {
			throw AddProjectError.projectAlreadyExists
		}
		guard url.isValidUnityProject else {
			throw AddProjectError.invalidUnityProject
		}

		let project = ProjectMetadata(url: url)
		projects.append(project)
	}

	func removeProject(at url: URL) {
		projects.removeAll(where: { $0.url == url })
	}
}
