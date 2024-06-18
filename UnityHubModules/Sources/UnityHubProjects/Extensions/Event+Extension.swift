import Combine
import Foundation
import UnityHubCommon

extension Event {
	static let importProject = Passthrough<ImportProjectReceiver.Completion>()
	static let removeProject = Passthrough<URL>()
	static let invalidProject = Passthrough<Void>()
}
