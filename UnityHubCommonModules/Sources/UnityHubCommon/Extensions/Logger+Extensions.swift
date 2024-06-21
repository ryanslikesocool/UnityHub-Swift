import OSLog

extension Logger {
	@usableFromInline static let module: Logger = Logger(
		subsystem: "\(Bundle.main.bundleIdentifier!).UnityHubCommon",
		category: "UnityHubCommon"
	)
}
