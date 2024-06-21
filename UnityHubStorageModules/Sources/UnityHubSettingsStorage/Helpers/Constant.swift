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

		public enum Locations {
			public static let defaultInstallationLocation: URL = URL.applicationDirectory
				.appending(component: "Unity", directoryHint: .isDirectory)

			public static let defaultDownloadLocation: URL = URL.cachesDirectory
				.appending(component: "Unity", directoryHint: .isDirectory)

			public static let defaultOfficialHubLocation: URL = URL.applicationDirectory
				.appending(component: "Unity Hub.app", directoryHint: .notDirectory)

			public static let unityHubBundleIdentifier: String = "com.unity3d.unityhub"
		}
	}
}
