import UnityHubStorageInstallations
import UnityHubShell

extension UnityEditorVersion: ShellArgumentProtocol {
	public var shellArgument: String { description }
}
