import Foundation
import UnityHubCommon

public extension Constant.Settings {
	enum Locations {
		public static let defaultInstallationLocation: URL = URL.applicationDirectory
			.appending(component: #"Unity"#, directoryHint: .isDirectory)

		public static let defaultDownloadLocation: URL = URL.cachesDirectory
			.appending(component: #"Unity"#, directoryHint: .isDirectory)

		public static let defaultOfficialHubLocation: URL = URL.applicationDirectory
			.appending(component: #"Unity Hub.app"#, directoryHint: .notDirectory)
	}
}
