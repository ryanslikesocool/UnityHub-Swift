import Foundation
import UnityHubCommon
import UnityHubStorage

public extension Event {
	enum Installation {
//		@MainActor public static let locate = Passthrough<LocateEventCompletion>()
//		@MainActor public static let remove = Passthrough<URL>()
		@MainActor public static let invalid = Passthrough<Void>()
//		@MainActor public static let missingAtURL = Passthrough<URL>()
		@MainActor public static let missingVersion = Passthrough<UnityEditorVersion>()
//		@MainActor public static let download = Passthrough<Void>()
	}
}
