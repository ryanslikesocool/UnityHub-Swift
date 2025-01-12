@frozen
public struct InstallationModule: RawRepresentable {
	public typealias RawValue = String

	public let rawValue: RawValue

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

// MARK: - Encodable

extension InstallationModule: Encodable {
	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(rawValue)
	}
}

// MARK: - Decodable

extension InstallationModule: Decodable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()
		try self.init(rawValue: container.decode(RawValue.self))
	}
}

// MARK: - ExpressibleByStringLiteral

extension InstallationModule: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self.init(rawValue: value)
	}
}

// MARK: - Convenience

public extension InstallationModule {
	init(_ rawValue: RawValue) {
		self.init(rawValue: rawValue)
	}
}

// MARK: - Constants

public extension InstallationModule {
	static let documentation: Self = "documentation"
	static let visualStudio: Self = "visualstudio"
	static let vuforiaAugmentedReality: Self = "vuforia-ar"

	static let iOS: Self = "ios"
	static let visionOS: Self = "visionos"
	static let tvOS: Self = "appletv"
	static let webGL: Self = "webgl"
	static let luminOS: Self = "lumin"

	static let android: Self = "android"
	static let android_SDKNDKBuildTools: Self = "android-sdk-ndk-tools"
	static let android_openJDK: Self = "android-open-jdk"

	static let linux_mono: Self = "linux-mono"
	static let linux_il2cpp: Self = "linux-il2cpp"
	static let linux_server: Self = "linux-server"

	static let windows: Self = "windows"
	static let windows_mono: Self = "windows-mono"
	static let windows_server: Self = "windows-server"

	static let universalWindowsPlatform: Self = "universal-windows-platform"
	static let uwp_il2cpp: Self = "uwp-il2cpp"
	static let uwp_dotnet: Self = "uwp-.net"

	static let mac_mono: Self = "mac-mono"
	static let mac_il2cpp: Self = "mac-il2cpp"
	static let mac_server: Self = "mac-server"

	static let languagePack_ja: Self = "language-ja"
	static let languagePack_ko: Self = "language-ko"
	static let languagePack_zh_cn: Self = "language-zh-cn"
	static let languagePack_zh_hant: Self = "language-zh-hant"
	static let languagePack_zh_hans: Self = "language-zh-hans"
}
