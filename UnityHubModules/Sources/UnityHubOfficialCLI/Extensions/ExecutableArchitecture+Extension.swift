import UnityHubCommon
import UnityHubShell

extension ExecutableArchitecture: ShellArgumentProtocol {
	public var shellArgument: String { rawValue }
}
