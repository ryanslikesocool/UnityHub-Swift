import Combine
import MoreWindows
import UnityHubCommon

public extension Event {
	@MainActor static let locationError = PassthroughSubject<(WindowID, LocationError), Never>()
	@MainActor static let applicationError = PassthroughSubject<(WindowID, ApplicationError), Never>()
}
