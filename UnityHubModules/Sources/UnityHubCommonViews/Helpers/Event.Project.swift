import Combine
import Foundation
import UnityHubCommon

public extension Event {
	enum Project {
		public static let locate = Passthrough<LocateEventCompletion>()
		public static let remove = Passthrough<URL>()
		public static let invalid = Passthrough<Void>()
		public static let missing = Passthrough<URL>()
		public static let displayInfo = Passthrough<URL>()
		public static let create = Passthrough<Void>()
	}
}
