import UnityHubShell

public extension OfficialHubArgument {
	enum EditorsArgument: String {
		case all = "--all"
		case releases = "--releases"
		case installed = "--installed"
	}
}

// MARK: - ShellArgumentProtocol

extension OfficialHubArgument.EditorsArgument: ShellArgumentProtocol {
	public var shellArgument: String { rawValue }
}
