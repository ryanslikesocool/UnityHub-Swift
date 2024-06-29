import Combine
import Foundation
import UnityHubCommon
import UnityHubStorage

public extension Event {
	enum Installation {
		public static let locate = Passthrough<LocateEventCompletion>()
		public static let remove = Passthrough<URL>()
		public static let invalid = Passthrough<Void>()
		public static let missingAtURL = Passthrough<URL>()
		public static let missingVersion = Passthrough<UnityEditorVersion>()
		public static let download = Passthrough<Void>()
	}
}
