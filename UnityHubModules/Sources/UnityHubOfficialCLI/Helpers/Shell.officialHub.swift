import Foundation
import UnityHubCommon
import UnityHubStorageInstallations
import UnityHubStorageSettings

public extension Shell {
	static var officialHub: ShellType<OfficialHubArgument> {
		get async throws {
			let hubLocation = await LocationSettings.shared.officialHubLocation ?? LocationSettings.defaultOfficialHubLocation
			let executable = try Utility.Application.getBundleExecutable(from: hubLocation)
			return ShellType<OfficialHubArgument>(executable: executable)
		}
	}
}

// MARK: - Argument

/// Arguments taken from the
/// [official documentation](https://docs.unity3d.com/hub/manual/HubCLI.html)\.
public enum OfficialHubArgument {
	case headless
	case help
	case editors(EditorsArgument)
	case installPath(InstallPathArgument)
	case install(version: UnityEditorVersion, changeset: String?, modules: Set<InstallationModule>?, childModules: Bool, architecture: ExecutableArchitecture)
	case installModules(version: UnityEditorVersion, modules: Set<InstallationModule>, childModules: Bool)
	case url(URL)
	case some(String)

	public enum InstallPathArgument: String {
		case get = "--get"
		case set = "--set"
	}

	public enum EditorsArgument: String {
		case all = "--all"
		case releases = "--releases"
		case installed = "--installed"
	}
}

// MARK: - ShellArgumentProtocl

extension OfficialHubArgument: ShellArgumentProtocol {
	public var shellArgument: String {
		lazy var args: [String] = []

		switch self {
			case .headless:
				args.append("--")
				args.append("--headless")
			case .help:
				return "help"
			case let .editors(arg):
				args.append("editors")
				args.append(arg.shellArgument)
			case let .installPath(arg):
				args.append("install-path")
				args.append(arg.shellArgument)
			case let .install(version, changeset, modules, childModules, architecture):
				args.append("install")

				args.append("--version")
				args.append(version.shellArgument)

				if let changeset {
					args.append("--changeset")
					args.append(changeset)
				}
				if let modules {
					args.append("--module")
					args.append(contentsOf: modules.map(\.shellArgument))
				}
				if childModules {
					args.append("--childModules")
				}

				args.append(architecture.shellArgument)
			case let .installModules(version, modules, childModules):
				args.append("install-modules")

				args.append("--version")
				args.append(version.shellArgument)

				args.append("--modules")
				args.append(contentsOf: modules.map(\.shellArgument))

				if childModules {
					args.append("--childModules")
				}
			case let .url(url):
				return url.shellArgument
			case let .some(arg):
				return arg
		}

		return args.joined(separator: " ")
	}
}

extension OfficialHubArgument.InstallPathArgument: ShellArgumentProtocol {
	public var shellArgument: String { rawValue }
}

extension OfficialHubArgument.EditorsArgument: ShellArgumentProtocol {
	public var shellArgument: String { rawValue }
}

extension UnityEditorVersion: ShellArgumentProtocol {
	public var shellArgument: String { description }
}

extension ExecutableArchitecture: ShellArgumentProtocol {
	public var shellArgument: String { rawValue }
}

extension InstallationModule: ShellArgumentProtocol {
	public var shellArgument: String { rawValue }
}

// MARK: - ExpressibleByStringLiteral

extension OfficialHubArgument: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self = .some(value)
	}
}
