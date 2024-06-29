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

		/// The app bundle identifier to check against.  Only the Unity Hub app should have this bundle identifier.
		static let validOfficialHubApplicationBundleIdentifier: String = #"com.unity3d.unityhub"#
	}
}
