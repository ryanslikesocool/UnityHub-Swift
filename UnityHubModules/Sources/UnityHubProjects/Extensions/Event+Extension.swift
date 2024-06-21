import Combine
import Foundation
import UnityHubCommon

extension Event {
	static let locateProject = Passthrough<LocateProjectReceiver.Completion>()
	static let removeProject = Passthrough<URL>()
	static let invalidProject = Passthrough<Void>()
	static let missingProject = Passthrough<URL>()
	static let displayProjectInfo = Passthrough<URL>()
	static let createProject = Passthrough<Void>()
}
