import Foundation
import UnityHubCommon

public extension Constant {
	enum Settings {
		static let directory: URL = Constant.applicationSupportDirectory
			.appending(component: "settings", directoryHint: .isDirectory)

		static func fileURL(for category: SettingsCategory) -> URL {
			Constant.Settings.directory
				.appending(component: "\(category.fileName).plist", directoryHint: .notDirectory)
		}
	}
}
