import Foundation
import MoreWindows

public enum Constant {
	public static let applicationSupportDirectory: URL = URL.applicationSupportDirectory
		.appending(components: "Developed With Love", AppInformation.appName, directoryHint: .isDirectory)
}
