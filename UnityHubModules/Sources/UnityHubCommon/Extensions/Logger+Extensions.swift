import OSLog

package extension Logger {
	static var unityHubSubmodule: String { Bundle.main.bundleIdentifier! }
}

extension Logger {
	@usableFromInline static let module: Logger = Logger(subsystem: Self.unityHubSubmodule, category: "UnityHubCommon")
}
