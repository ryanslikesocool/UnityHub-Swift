import UnityHubShell
import UnityHubStorageInstallations

extension InstallationModule: ShellArgumentProtocol {
	public var shellArgument: String { rawValue }
}
