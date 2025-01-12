import UnityHubShell

public extension OfficialHubArgument {
	enum InstallPathArgument: String {
		case get = "--get"
		case set = "--set"
	}
}

// MARK: - ShellArgumentProtocol

extension OfficialHubArgument.InstallPathArgument: ShellArgumentProtocol {
	public var shellArgument: String { rawValue }
}
