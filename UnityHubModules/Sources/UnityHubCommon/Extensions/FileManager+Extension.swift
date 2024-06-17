import Foundation

public extension FileManager {
	func fileExists(at url: URL) -> Bool {
		fileExists(atPath: url.path(percentEncoded: false))
	}

	func directoryExists(at url: URL) -> Bool {
		var bool: ObjCBool = false
		return fileExists(atPath: url.path(percentEncoded: false), isDirectory: &bool) && bool.boolValue
	}
}
