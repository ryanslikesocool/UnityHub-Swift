import Foundation
import UnityHubCommon

public extension Constant {
	enum Application {
		/// - Remark: This path is relative to `Some Application.app`.
		static let infoPlistPath: String = #"Contents/Info.plist"#

		/// - Remark: This path is relative to `Some Application.app`.
		public static let executableDirectoryPath: String = #"/Contents/MacOS"#

		static let bundleVersionKey: String = "CFBundleVersion"
		static let bundleIdentifierKey: String = "CFBundleIdentifier"
		static let bundleExecutableKey: String = "CFBundleExecutable"
		static let unityBuildNumberKey: String = "UnityBuildNumber"
	}
}
