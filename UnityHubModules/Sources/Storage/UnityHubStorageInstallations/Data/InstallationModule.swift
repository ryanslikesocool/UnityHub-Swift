@frozen
public struct InstallationModule: RawRepresentable {
	public let rawValue: String

	public init(rawValue: RawValue) {
		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension InstallationModule: Sendable { }

// MARK: - Equatable

extension InstallationModule: Equatable { }

// MARK: - Hashable

extension InstallationModule: Hashable { }

// MARK: - Identifiable

extension InstallationModule: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension InstallationModule: Codable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()
		try self.init(rawValue: container.decode(RawValue.self))
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(rawValue)
	}
}

// MARK: - ExpressibleByStringLiteral

extension InstallationModule: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self.init(rawValue: value)
	}
}

// MARK: - Constants

public extension InstallationModule {
	static let documentation: InstallationModule = "documentation"
	static let visualStudio: InstallationModule = "visualstudio"
	static let vuforiaAugmentedReality: InstallationModule = "vuforia-ar"

	static let iOS: InstallationModule = "ios"
	static let visionOS: InstallationModule = "visionos"
	static let tvOS: InstallationModule = "appletv"
	static let webGL: InstallationModule = "webgl"
	static let luminOS: InstallationModule = "lumin"

	static let android: InstallationModule = "android"
	static let android_SDKNDKBuildTools: InstallationModule = "android-sdk-ndk-tools"
	static let android_openJDK: InstallationModule = "android-open-jdk"

	static let linux_mono: InstallationModule = "linux-mono"
	static let linux_il2cpp: InstallationModule = "linux-il2cpp"
	static let linux_server: InstallationModule = "linux-server"

	static let windows: InstallationModule = "windows"
	static let windows_mono: InstallationModule = "windows-mono"
	static let windows_server: InstallationModule = "windows-server"

	static let universalWindowsPlatform: InstallationModule = "universal-windows-platform"
	static let uwp_il2cpp: InstallationModule = "uwp-il2cpp"
	static let uwp_dotnet: InstallationModule = "uwp-.net"

	static let mac_mono: InstallationModule = "mac-mono"
	static let mac_il2cpp: InstallationModule = "mac-il2cpp"
	static let mac_server: InstallationModule = "mac-server"

	static let languagePack_ja: InstallationModule = "language-ja"
	static let languagePack_ko: InstallationModule = "language-ko"
	static let languagePack_zh_cn: InstallationModule = "language-zh-cn"
	static let languagePack_zh_hant: InstallationModule = "language-zh-hant"
	static let languagePack_zh_hans: InstallationModule = "language-zh-hans"
}
