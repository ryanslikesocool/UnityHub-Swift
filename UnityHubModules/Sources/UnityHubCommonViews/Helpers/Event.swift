import MoreWindows
import UnityHubCommon

public extension Event {
	@MainActor static let locationError = Passthrough<WindowID, LocationError>()
	@MainActor static let applicationError = Passthrough<WindowID, ApplicationError>()
}
