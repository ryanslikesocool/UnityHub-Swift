import Foundation
import UnityHubCommon

public extension Event {
	enum Project {
		@MainActor public static let locate = Passthrough<LocateEventCompletion>()
		@MainActor public static let remove = Passthrough<URL>()
		@MainActor public static let invalid = Passthrough<Void>()
		@MainActor public static let missing = Passthrough<URL>()
		@MainActor public static let displayInfo = Passthrough<URL>()
		@MainActor public static let create = Passthrough<Void>()
	}
}
