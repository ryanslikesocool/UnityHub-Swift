import Foundation

public extension FileManager {
	@inlinable
	func fileExists(at url: URL, appending appendingPath: some StringProtocol) -> Bool {
		fileExists(at: url.appending(path: appendingPath, directoryHint: .notDirectory))
	}

	@inlinable
	func fileExists(at url: URL) -> Bool {
		fileExists(atPath: url.path(percentEncoded: false))
	}

	@inlinable
	func directoryExists(at url: URL, appending appendingPath: some StringProtocol) -> Bool {
		directoryExists(at: url.appending(path: appendingPath, directoryHint: .isDirectory))
	}

	@inlinable
	func directoryExists(at url: URL) -> Bool {
		var bool: ObjCBool = false
		return fileExists(atPath: url.path(percentEncoded: false), isDirectory: &bool) && bool.boolValue
	}

	@inlinable
	func contentsOfDirectory(at url: URL) throws -> [URL] {
		try contentsOfDirectory(atPath: url.path(percentEncoded: false))
			.map { url.appending(component: $0) }
	}
}
