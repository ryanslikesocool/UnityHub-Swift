import Foundation

public extension URL {
	static let preferencesDirectory: Self = Self.libraryDirectory
		.appending(component: "Preferences", directoryHint: .isDirectory)

	static let localPreferencesDirectory: Self = Self.preferencesDirectory
		.appending(component: Bundle.main.bundleIdentifier!, directoryHint: .isDirectory)

	static let persistentStorageDirectory: Self = Self.applicationSupportDirectory
		.appending(component: Bundle.main.bundleIdentifier!, directoryHint: .isDirectory)
}
