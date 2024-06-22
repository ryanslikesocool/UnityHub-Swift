import Combine
import Foundation
import UnityHubCommon

extension Event {
	enum Project {
		static let locate = Passthrough<LocateProjectReceiver.Completion>()
		static let remove = Passthrough<URL>()
		static let invalid = Passthrough<Void>()
		static let missing = Passthrough<URL>()
		static let displayInfo = Passthrough<URL>()
		static let create = Passthrough<Void>()
	}
}
