extension InstallationMetadata {
	/// - Remark: This object should only exist in a transient state while reading from the editor application's `Info.plist`
	struct SimpleInfoPlist {
		let bundleIdentifier: String
		let bundleVersion: UnityEditorVersion
	}
}

// MARK: - Decodable

extension InstallationMetadata.SimpleInfoPlist: Decodable {
	private enum CodingKeys: String, CodingKey {
		case bundleIdentifier = "CFBundleIdentifier"
		case bundleVersion = "CFBundleVersion"
	}
}
