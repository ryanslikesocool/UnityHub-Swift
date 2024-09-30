import Foundation
import OSLog
import UnityHubCommon
import UHStorage_Installations
import UHStorage_Common

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

		try container.encode(projects.sorted { (lhs, rhs) in
			lhs.url.path() < rhs.url.path()
		})
	}
}

// MARK: - GlobalFile

extension ProjectCache: CacheFile {
	public static let shared: ProjectCache = ProjectCache.load()

	public static let category: CacheCategory = .projects
}

// MARK: -

public extension ProjectCache {
	func openProject(at url: URL, with someVersion: UnityEditorVersion?) throws {
		let version: UnityEditorVersion = try unwrapVersion()

		try Self.validateProjectContent(at: url)

		guard let installation = InstallationCache.shared[version] else {
			throw InstallationError.missingInstallationForVersion(version)
		}
		try Utility.Application.Unity.validateInstallation(at: installation.url)

		let installationURL: URL = try Utility.Application
			.getBundleExecutable(from: installation.url)

		Task {
			do {
				try Shell.zsh(.c, .url(installationURL), "-projectPath", .url(url))
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
