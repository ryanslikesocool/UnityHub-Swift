import Foundation
import UnityHubCommon
import UnityHubShell
import UnityHubStorageSettings

public extension Shell {
	static var officialHub: ShellType<OfficialHubArgument> {
		get async throws {
			let hubLocation = await LocationSettings.shared.officialHubLocation ?? LocationSettings.defaultOfficialHubLocation
			let executableURL = try Utility.Application.getBundleExecutable(from: hubLocation)
			return ShellType(executableURL: executableURL)
		}
	}
}
