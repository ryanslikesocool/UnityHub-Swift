import Foundation

public extension URL {
	static let preferencesDirectory: Self = Self.libraryDirectory
		.appending(component: "Preferences", directoryHint: .isDirectory)

	static let localPreferencesDirectory: Self = Self.preferencesDirectory
		.appending(component: Bundle.main.bundleIdentifier!, directoryHint: .isDirectory)

	static let persistentStorageDirectory: Self = Self.applicationSupportDirectory
		.appending(component: Bundle.main.bundleIdentifier!, directoryHint: .isDirectory)

	static let unityResource = UnityResource.self

	enum UnityResource {
		public static let officialUnityHub: URL! = URL(string: "https://unity.com/download")
		public static let manual: URL! = URL(string: "https://docs.unity3d.com/Manual/index.html")
		public static let scripting: URL! = URL(string: "https://docs.unity3d.com/ScriptReference/index.html")
		public static let unityLearn: URL! = URL(string: "https://learn.unity.com/")
		public static let unityBlog: URL! = URL(string: "https://blog.unity.com")
		public static let releaseArchive: URL! = URL(string: "https://unity.com/releases/editor/archive")
		public static let discussions: URL! = URL(string: "https://discussions.unity.com")
		public static let forums: URL! = URL(string: "https://forum.unity.com")
		public static let unityPulse: URL! = URL(string: "https://unity.com/unity-pulse")
		public static let unite: URL! = URL(string: "https://unity.com/unite")
		public static let unityAssetStore: URL! = URL(string: "https://assetstore.unity.com")
		public static let onDemandTraining: URL! = URL(string: "https://unity.com/products/on-demand-training")
		public static let unityMuse: URL! = URL(string: "https://unity.com/muse")
		public static let cloudLogin: URL! = URL(string: "https://cloud.unity.com/login")
		public static let accountHelp: URL! = URL(string: "https://support.unity.com/hc/en-us/sections/201104779-Accounts-UDN")
		public static let bugReport: URL! = URL(string: "https://github.com/ryanslikesocool/UnityHub-Swift/issues")

		public static var logDirectory: URL {
			URL.applicationSupportDirectory
				.appending(path: "UnityHub/logs", directoryHint: .isDirectory)
		}
	}
}
