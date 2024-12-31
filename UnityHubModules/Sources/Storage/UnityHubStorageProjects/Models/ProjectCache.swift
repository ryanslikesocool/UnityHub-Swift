import Combine
import Foundation
import OSLog
import UnityHubCommon
import UnityHubStorageCommon
import UnityHubStorageInstallations

@MainActor
public struct ProjectCache {
	public var projects: [ProjectMetadata]

	public var projectEditorVersions: [UnityEditorVersion] {
		Set(projects.compactMap(\.editorVersion)).sorted()
	}

	public nonisolated init() {
		projects = []
	}
}

// MARK: - Sendable

extension ProjectCache: Sendable { }

// MARK: - Equatable

extension ProjectCache: Equatable { }

// MARK: - Hashable

extension ProjectCache: Hashable { }

// MARK: - Codable

extension ProjectCache: @preconcurrency Encodable, @preconcurrency Decodable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()

		self.init()

		projects = try container.decode()
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()

		try container.encode(projects.sorted { lhs, rhs in
			lhs.url.path() < rhs.url.path()
		})
	}
}

// MARK: - SingletonFileProtocol

extension ProjectCache: SingletonFileProtocol {
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

extension ProjectCache: CacheFileProtocol {
	public nonisolated static let category: CacheCategory = .projects
}

// MARK: -

public extension ProjectCache {
	mutating func openProject(at url: URL, with someVersion: UnityEditorVersion?) async throws {
		let version: UnityEditorVersion = try unwrapVersion()

		try Self.validateProjectContent(at: url)

		guard let installation = InstallationCache.shared[version] else {
			throw InstallationError.missingInstallationForVersion(version)
		}
		try Utility.Application.Unity.validateInstallation(at: installation.url)

		let installationURL: URL = try Utility.Application
			.getBundleExecutable(from: installation.url)

		do {
			try Shell.zsh(.c, .url(installationURL), "-projectPath", .url(url))
		} catch {
			throw ShellError(error)
		}

		await MainActor.run {
			// Only change if shell command succeeds
			self[url]?.lastOpened = .now
			write()
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
