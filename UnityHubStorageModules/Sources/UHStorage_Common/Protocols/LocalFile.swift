import Foundation

public protocol LocalFile: Codable {
	static func read(from url: URL) throws -> Self

	func write(to url: URL) throws

	/// With the default ``read`` implementation, this is called immediately after successfully reading the file.
	/// Perform any necessary setup here.
	mutating func initialize()
}

// MARK: - Default Implementation

public extension LocalFile {
	static func read(from url: URL) throws -> Self {
		let decoder = PropertyListDecoder.shared

		let data: Data
		do {
			data = try Data(contentsOf: url)
		} catch {
			throw LocalFileSerializationError.dataReadFailure(url, error)
		}

		var value: Self
		do {
			value = try decoder.decode(Self.self, from: data)
		} catch {
			throw LocalFileSerializationError.decodeFailure(Self.self, error)
		}

		value.initialize()
		return value
	}

	func write(to url: URL) throws {
		let encoder = PropertyListEncoder.shared
		encoder.outputFormat = .binary

		do {
			let fileManager = FileManager.default
			let directoryPath: String = url
				.deletingLastPathComponent()
				.path(percentEncoded: false)

			// it's recommended to just attempt operation
			// instead of checking and then attempting
//		if !fileManager.fileExists(atPath: directoryPath) {
			try fileManager.createDirectory(
				atPath: directoryPath,
				withIntermediateDirectories: true
			)
//		}
		} catch {
			throw LocalFileSerializationError.directoryValidationFailure(url, error)
		}

		let data: Data
		do {
			data = try encoder.encode(self)
		} catch {
			throw LocalFileSerializationError.encodeFailure(Self.self, error)
		}

		do {
			try data.write(to: url)
		} catch {
			throw LocalFileSerializationError.dataWriteFailure(url, error)
		}
	}

	func initialize() { }
}
