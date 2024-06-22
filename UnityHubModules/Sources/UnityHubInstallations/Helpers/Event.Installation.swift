import Combine
import Foundation
import UnityHubCommon

extension Event {
	enum Installation {
		static let locate = Passthrough<LocateInstallationReceiver.Completion>()
		static let remove = Passthrough<URL>()
		static let invalid = Passthrough<Void>()
		static let missing = Passthrough<URL>()
		static let download = Passthrough<Void>()
	}
}
