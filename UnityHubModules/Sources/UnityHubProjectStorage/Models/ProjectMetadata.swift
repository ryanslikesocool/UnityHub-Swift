import OSLog
import SwiftUI
import UnityHubCommon
import UnityHubInstallationsStorage
import UnityHubSettingsStorage
import UserIcon

public struct ProjectMetadata {
	public let url: URL
	public var pinned: Bool
	public var lastOpened: Date?

	public private(set) var name: String?
	public private(set) var developer: String?
	public var embedded: Embedded { didSet { saveEmbeddedMetadata() } }

	public var editorVersion: UnityEditorVersion? { getEditorVersion() }

	public var icon: UserIcon {
		get { embedded.icon }
		set { embedded.icon = newValue }
	}

	public var exists: Bool { (try? url.checkResourceIsReachable()) ?? false }

	public init(url: URL) {
		self.url = url
		pinned = false
		lastOpened = nil

		name = url.lastPathComponent
		embedded = Embedded()

		validateLazyData()
	}

	init(copy oldValue: borrowing Self, with newURL: URL) {
		url = newURL
		pinned = oldValue.pinned
		lastOpened = oldValue.lastOpened
		name = newURL.lastPathComponent
		embedded = Embedded()

		validateLazyData()
	}
}

// MARK: - Hashable

extension ProjectMetadata: Hashable { }

// MARK: - Identifiable

extension ProjectMetadata: Identifiable {
	public var id: URL { url }
}

// MARK: - Codable

extension ProjectMetadata: Codable {
	private enum CodingKeys: CodingKey {
		case url
		case pinned
		case lastOpened
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let url: URL = try container.decode(forKey: .url)

		self.init(url: url)

		pinned = try container.decodeIfPresent(forKey: .pinned) ?? false
		lastOpened = try container.decodeIfPresent(forKey: .lastOpened)
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(url, forKey: .url)
		try container.encode(pinned, forKey: .pinned)
		try container.encodeIfPresent(lastOpened, forKey: .lastOpened)
	}
}

// MARK: - Constants

extension ProjectMetadata {
	static let assetsFilePath: String = "Assets"
	static let projectSettingsPath: String = "ProjectSettings"

	static let editorVersionKey: String = "m_EditorVersion"
	static let productNameKey: String = "productName"
	static let companyNameKey: String = "companyName"

	static let projectVersionFilePath: String = "\(projectSettingsPath)/ProjectVersion.txt"
	static let projectSettingsFilePath: String = "\(projectSettingsPath)/ProjectSettings.asset"
}

// MARK: -

private extension ProjectMetadata {
	func saveEmbeddedMetadata() {
		guard exists else {
			// fail silently if project is missing
			return
		}

		let data: Data
		do {
			data = try JSONEncoder.shared
				.withOutputFormatting([.prettyPrinted, .sortedKeys])
				.encode(embedded)
		} catch {
			Logger.module.error("""
			Failed to encode \(Embedded.self) to data:
			\(error.localizedDescription)
			""")
			return
		}

		let url: URL = relativeURL(path: Embedded.fileName)

		do {
			try data.write(to: url)
		} catch {
			Logger.module.error("""
			Failed to write data to \(url.path(percentEncoded: false)):
			\(error.localizedDescription)
			""")
		}
	}
}

// MARK: - Lazy

private extension ProjectMetadata {
	mutating func validateLazyData() {
		validateProjectSettings()
		validateEmbeddedMetadata()
	}

	mutating func validateProjectSettings() {
		guard let lines = getProjectSettings() else {
			return
		}

		name = MiniYaml.readValue(in: lines, forKey: Self.productNameKey) ?? url.lastPathComponent
		developer = MiniYaml.readValue(in: lines, forKey: Self.companyNameKey)
	}

	mutating func validateEmbeddedMetadata() {
		guard let embedded = getEmbeddedMetadata() else {
			return
		}

		self.embedded = embedded
	}
}

private extension ProjectMetadata {
	func getProjectSettings() -> [String]? {
		do {
			return try readLines(at: Self.projectSettingsFilePath)
		} catch {
			Self.logReadError(description: "string lines", at: url, error: error)
			return nil
		}
	}

	func getEmbeddedMetadata() -> Embedded? {
		let data: Data
		do {
			data = try readData(at: Embedded.fileName)
		} catch {
			Self.logReadError(description: "data", at: url, error: error)
			return nil
		}

		return JSONDecoder.shared.attemptDecode(Embedded.self, from: data)
	}

	func getEditorVersion() -> UnityEditorVersion? {
		let url = relativeURL(path: Self.projectVersionFilePath)
		let editorVersionString: String
		do {
			if let value = try MiniYaml.readValue(in: url, forKey: Self.editorVersionKey) {
				editorVersionString = value
			} else {
				return nil
			}
		} catch {
			Self.logReadError(description: "editor version", at: url, error: error)
			return nil
		}

		return UnityEditorVersion(editorVersionString)
	}
}

// MARK: - Utility

private extension ProjectMetadata {
	static func logReadError(description: @autoclosure @escaping () -> String, at url: URL, error: Error) {
		Logger.module.warning("""
		Failed to read \(description()) from \(url.path(percentEncoded: false)):
		\(error.localizedDescription)
		""")
	}

	func relativeURL(path relativePath: String, directoryHint: URL.DirectoryHint = .inferFromPath) -> URL {
		url.appending(path: relativePath, directoryHint: directoryHint)
	}

	func readString(at relativePath: String) throws -> String {
		let url: URL = relativeURL(path: relativePath, directoryHint: .notDirectory)
		return try String(contentsOf: url)
	}

	func readLines(at relativePath: String) throws -> [String] {
		let string = try readString(at: relativePath)
		return string.components(separatedBy: .newlines)
	}

	func readData(at relativePath: String) throws -> Data {
		let url: URL = relativeURL(path: relativePath, directoryHint: .notDirectory)
		return try Data(contentsOf: url)
	}
}
