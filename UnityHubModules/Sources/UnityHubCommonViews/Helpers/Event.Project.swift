import Combine
import Foundation
import UnityHubCommon

public extension Event {
	enum Project {
		@MainActor public static let locate = PassthroughSubject<LocateEventCompletion, Never>()
		@MainActor public static let remove = PassthroughSubject<URL, Never>()
		@MainActor public static let invalid = PassthroughSubject<Void, Never>()
		@MainActor public static let missing = PassthroughSubject<URL, Never>()
		@MainActor public static let displayInfo = PassthroughSubject<URL, Never>()
		@MainActor public static let create = PassthroughSubject<Void, Never>()
	}
}
