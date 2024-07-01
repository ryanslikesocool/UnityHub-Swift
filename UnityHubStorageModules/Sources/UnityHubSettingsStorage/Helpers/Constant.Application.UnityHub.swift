import UnityHubCommon
import UnityHubStorageCommon

public extension Constant.Application {
	enum UnityHub {
		/// The app bundle identifier to check against.  Only the Unity Hub app should have this bundle identifier.
		static let validOfficialHubApplicationBundleIdentifier: String = #"com.unity3d.unityhub"#
	}
}
