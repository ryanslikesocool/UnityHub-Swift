import OSLog

extension Logger {
	@usableFromInline static let module: Logger = Logger(subsystem: Self.unityHubSubmodule, category: "UnityHubLauncher")
}
