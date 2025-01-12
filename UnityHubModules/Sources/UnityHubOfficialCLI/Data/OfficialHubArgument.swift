import Foundation
import UnityHubCommon
import UnityHubShell
import UnityHubStorageInstallations
import UnityHubStorageSettings

/// Arguments taken from the
/// [official documentation]( https://docs.unity3d.com/hub/manual/HubCLI.html ).
public struct OfficialHubArgument: RawRepresentable {
	public typealias RawValue = String

	public let rawValue: RawValue

	public init(rawValue: RawValue) {
		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension OfficialHubArgument: Sendable { }

// MARK: - ShellArgumentProtocl

extension OfficialHubArgument: ShellArgumentProtocol {
	public var shellArgument: String { rawValue }
}

// MARK: - ExpressibleByStringLiteral

extension OfficialHubArgument: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self.init(rawValue: value)
	}
}

// MARK: - ExpressibleByArrayLiteral

extension OfficialHubArgument: ExpressibleByArrayLiteral {
	public init(arrayLiteral elements: RawValue...) {
		self.init(elements)
	}
}

// MARK: - Convenience

public extension OfficialHubArgument {
	init(_ rawValue: RawValue) {
		self.init(rawValue: rawValue)
	}

	init(_ elements: some Sequence<RawValue>) {
		self.init(rawValue: elements.joined(separator: " "))
	}
}

// MARK: - Constants

public extension OfficialHubArgument {
	static let headless: Self = [
		"--",
		"--headless",
	]

	static let help: Self = "help"

	/// - Parameters:
	///   - argument:
	static func editors(
		_ argument: EditorsArgument
	) -> Self {
		[
			"editors",
			argument.shellArgument,
		]
	}

	/// - Parameters:
	///   - argument:
	static func installPath(
		_ argument: InstallPathArgument
	) -> Self {
		[
			"install-path",
			argument.shellArgument,
		]
	}

	/// - Parameters:
	///   - version:
	///   - changeset:
	///   - modules:
	///   - childModules:
	///   - architecture:
	static func install(
		version: UnityEditorVersion,
		changeset: String?,
		modules: Set<InstallationModule>?,
		childModules: Bool,
		architecture: ExecutableArchitecture
	) -> Self {
		var arguments: [RawValue] = []

		arguments.append("install")

		arguments.append("--version")
		arguments.append(version.shellArgument)

		if let changeset {
			arguments.append("--changeset")
			arguments.append(changeset)
		}
		if let modules {
			arguments.append("--module")
			arguments.append(contentsOf: modules.map(\.shellArgument))
		}
		if childModules {
			arguments.append("--childModules")
		}

		arguments.append(architecture.shellArgument)

		return Self(arguments)
	}

	/// - Parameters:
	///   - version:
	///   - module:
	///   - childModules:
	static func installModules(
		version: UnityEditorVersion,
		modules: Set<InstallationModule>,
		childModules: Bool
	) -> Self {
		var arguments: [RawValue] = []

		arguments.append("install-modules")

		arguments.append("--version")
		arguments.append(version.shellArgument)

		arguments.append("--modules")
		arguments.append(contentsOf: modules.map(\.shellArgument))

		if childModules {
			arguments.append("--childModules")
		}

		return Self(arguments)
	}

	/// - Parameters:
	///   - url:
	static func url(
		_ url: URL
	) -> Self {
		Self(url.shellArgument)
	}
}
