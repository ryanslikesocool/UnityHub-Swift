import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubSettingsStorage
import UserIcon

public struct ProjectInfo {
	public var url: URL { user.url }
	public let metadataURL: URL

	public var project: ProjectMetadata
	public var user: ProjectUserMetadata

	public var name: String { url.lastPathComponent }
	public var path: String { url.abbreviatingWithTildeInPath }

	public var icon: UserIcon {
		get { project.icon }
		set { project.icon = newValue }
	}

	public var pinned: Bool {
		get { user.pinned }
		set { user.pinned = newValue }
	}

	public var lastOpened: Date? {
		get { user.lastOpened }
		set { user.lastOpened = newValue }
	}

	public var fileSize: String?

	public let editorVersion: UnityEditorVersion?
//	public let editorVersionWithRevision: String?

	public init(user: ProjectUserMetadata) {
		self.user = user
		metadataURL = user.url.appending(path: ProjectMetadata.fileName, directoryHint: .notDirectory)

		do {
			project = try ProjectMetadata(contentsOf: metadataURL)
		} catch {
			Logger.module.error("""
			Failed to load \(Self.self):
			\(error.localizedDescription)
			""")
			project = ProjectMetadata()
		}

		let editorVersionFile: URL = Self.getProjectVersionURL(from: user.url)
		do {
			let fileLines: [String] = try String(contentsOf: editorVersionFile).components(separatedBy: "\n")

			editorVersion = UnityEditorVersion(Self.getValue(in: fileLines, trimmingPrefix: Self.editorVersionPrefix))
//			editorVersionWithRevision = Self.getValue(in: fileLines, trimmingPrefix: Self.editorVersionWithRevisionPrefix)
		} catch {
			Logger.module.warning("""
			Failed to read editor version from \(editorVersionFile.path(percentEncoded: false)):
			\(error.localizedDescription)
			""")

			editorVersion = nil
//			editorVersionWithRevision = nil
		}
	}
}

// MARK: - Hashable

extension ProjectInfo: Hashable { }

// MARK: - Identifiable

extension ProjectInfo: Identifiable {
	public var id: URL { url }
}

// MARK: - Constants

private extension ProjectInfo {
	static let editorVersionPrefix: String = "m_EditorVersion: "
	static let editorVersionWithRevisionPrefix: String = "m_EditorVersionWithRevision: "
}

// MARK: -

public extension ProjectInfo {
	static func getProjectVersionURL(from url: URL) -> URL {
		url.appending(path: "ProjectSettings/ProjectVersion.txt", directoryHint: .notDirectory)
	}

	static func getValue(in components: [String], trimmingPrefix prefix: String) -> String? {
		if let value = components
			.first(where: { $0.starts(with: prefix) })?
			.trimmingPrefix(prefix)
		{
			String(value)
		} else {
			nil
		}
	}
}
