import Foundation
import UnityHubCommon

extension Constant.Application {
	enum Unity {
		/// - Remark: This path is relative to the directory containing `Unity.app`.
		static let modulesJSONPath: String = #"modules.json"#

		/// - Remark: This path is relative to the directory containing `Unity.app`.
		static let bugReporterPath: String = #"Unity Bug Reporter.app"#

		/// The app bundle identifier to check against.  Only Unity editor apps should have this bundle identifier.
		static let validBundleIdentifier: String = #"com.unity3d.UnityEditor5.x"#
	}
}
