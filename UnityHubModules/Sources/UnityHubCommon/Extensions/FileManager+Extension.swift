import Foundation

public extension FileManager {
	func fileExists(at url: URL, appending appendingPath: some StringProtocol) -> Bool {
		fileExists(at: url.appending(path: appendingPath, directoryHint: .notDirectory))
	}

	func fileExists(at url: URL) -> Bool {
		fileExists(atPath: url.path(percentEncoded: false))
	}

	func directoryExists(at url: URL, appending appendingPath: some StringProtocol) -> Bool {
		directoryExists(at: url.appending(path: appendingPath, directoryHint: .isDirectory))
	}

	func directoryExists(at url: URL) -> Bool {
		var bool: ObjCBool = false
		return fileExists(atPath: url.path(percentEncoded: false), isDirectory: &bool) && bool.boolValue
	}
}
