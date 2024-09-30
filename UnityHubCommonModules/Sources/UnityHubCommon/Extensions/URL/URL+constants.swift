import Foundation

public extension URL {
	static let persistentStorageDirectory: Self = Self.applicationSupportDirectory
		.appending(component: Bundle.main.bundleIdentifier!, directoryHint: .isDirectory)
}