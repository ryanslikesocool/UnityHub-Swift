/// - Remark: This object should only exist in a transient state while reading from the editor application's `Info.plist`
struct InstallationInfoPlist {
	let bundleIdentifier: String
	let bundleVersion: UnityEditorVersion
	let executable: String
	let buildNumber: String

	private init(
		bundleIdentifier: String,
		bundleVersion: UnityEditorVersion,
		executable: String,
		buildNumber: String
	) {
		self.bundleIdentifier = bundleIdentifier
		self.bundleVersion = bundleVersion
		self.executable = executable
		self.buildNumber = buildNumber
	}
}

// MARK: - Decodable

extension InstallationInfoPlist: Decodable {
	private enum CodingKeys: String, CodingKey {
		case bundleIdentifier = "CFBundleIdentifier"
		case bundleVersion = "CFBundleVersion"
		case executable = "CFBundleExecutable"
		case buildNumber = "UnityBuildNumber"
	}
}
