import Foundation
import AppKit
import MoreWindows

public enum Constant {
	public static let applicationSupportDirectory: URL = URL.applicationSupportDirectory
		.appending(components: "Developed With Love", NSApplication.shared.bundleName, directoryHint: .isDirectory)
}
