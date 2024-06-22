import Foundation

public enum Constant {
	public static let applicationSupportDirectory: URL = URL.applicationSupportDirectory
		.appending(component: Bundle.main.bundleIdentifier!, directoryHint: .isDirectory)

	public enum Link { }
}
