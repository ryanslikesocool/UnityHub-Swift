import OSLog
import SerializationKit
import SwiftUI

@Observable
public final class AppSettings {
	public static let shared: AppSettings = AppSettings.load()

	public var general: General { didSet { save() } }
	public var projects: Projects { didSet { save() } }

	private init() {
		general = General()
		projects = Projects()
	}
}

// MARK: - Codable

extension AppSettings: Codable {
	public enum CodingKeys: CodingKey {
		case general
		case projects
	}

	public convenience init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		general = try container.decodeIfPresent(forKey: .general) ?? general
		projects = try container.decodeIfPresent(forKey: .projects) ?? projects
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(general, forKey: .general)
		try container.encode(projects, forKey: .projects)
	}
}

// MARK: - Constants

private extension AppSettings {
	static var fileURL: URL {
		URL.applicationSupportDirectory
			.appending(component: Bundle.main.bundleIdentifier!, directoryHint: .isDirectory)
			.appending(component: "Unity Hub Settings.plist", directoryHint: .notDirectory)
	}

	static let encoder: PropertyListEncoder = {
		let encoder = PropertyListEncoder()
		encoder.outputFormat = .xml
		return encoder
	}()

	static let decoder: PropertyListDecoder = PropertyListDecoder()
}

// MARK: -

extension AppSettings {
	private static func load() -> AppSettings {
		let fileURL: URL = Self.fileURL

		let data: Data
		do {
			data = try Data(contentsOf: fileURL)
		} catch {
			Logger.module.error("""
			Failed to read data at \(fileURL.path(percentEncoded: false)):
			\(error.localizedDescription)
			""")
			return Self()
		}

		do {
			return try Self.decoder.decode(Self.self, from: data)
		} catch {
			Logger.module.error("""
			Failed to decode \(Self.self) from data at \(fileURL.path(percentEncoded: false)):
			\(error.localizedDescription)
			""")
			return Self()
		}
	}

	public func save() {
		let fileURL: URL = Self.fileURL

		do {
			let fileManager = FileManager.default
			let directoryPath: String = fileURL.deletingLastPathComponent().path(percentEncoded: false)

			if !fileManager.fileExists(atPath: directoryPath) {
				try fileManager.createDirectory(
					atPath: directoryPath,
					withIntermediateDirectories: true
				)
			}
		} catch {
			Logger.module.error("""
			Failed to validate save directory at \(fileURL.path(percentEncoded: false)):
			\(error.localizedDescription)
			""")
		}

		let data: Data
		do {
			data = try Self.encoder.encode(self)
		} catch {
			Logger.module.error("""
			Failed to encode \(Self.self) to data:
			\(error.localizedDescription)
			""")
			return
		}

		do {
			try data.write(to: fileURL)
		} catch {
			Logger.module.error("""
			Failed to write \(Self.self) data to \(fileURL.path(percentEncoded: false)):
			\(error.localizedDescription)
			""")
		}

		Logger.module.debug("Successfully wrote \(Self.self) to \(fileURL.path(percentEncoded: false)).")
	}
}
