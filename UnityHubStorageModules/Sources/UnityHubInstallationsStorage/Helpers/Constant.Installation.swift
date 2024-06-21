import Foundation
import UnityHubCommon

extension Constant {
	enum Installation {
		/// - Remark: This path is relative to `Unity.app`.
		static let infoPlistPath: String = "Contents/Info.plist"

		/// - Remark: This path is relative to the directory containing `Unity.app`.
		static let modulesJSONPath: String = "modules.json"

		/// - Remark: This path is relative to the directory containing `Unity.app`.
		static let bugReporterPath: String = "Unity Bug Reporter.app"

		/// - Remark: This path is relative to `Unity.app`.
		static let executableDirectoryPath: String = "Contents/MacOS"

		/// The app bundle identifier to check against.  Only Unity editor apps should have this bundle identifier.
		static let validApplicationBundleIdentifier: String = "com.unity3d.UnityEditor5.x"
	}
}
