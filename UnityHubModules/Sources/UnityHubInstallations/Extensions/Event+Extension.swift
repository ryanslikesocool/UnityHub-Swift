import Combine
import Foundation
import UnityHubCommon

extension Event {
	static let locateInstallation = Passthrough<LocateInstallationReceiver.Completion>()
	static let removeInstallation = Passthrough<URL>()
	static let invalidEditor = Passthrough<Void>()
	static let missingInstallation = Passthrough<URL>();
}
