import Combine
import Foundation
import MoreWindows
import UnityHubCommon

public extension Event {
	static let locationError = Passthrough<WindowID, LocationError>()
	static let applicationError = Passthrough<WindowID, ApplicationError>()
}
