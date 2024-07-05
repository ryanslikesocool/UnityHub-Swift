import OSLog

public extension Logger {
	@inlinable init(category: String) {
		self.init(subsystem: Self.subsystem, category: category)
	}
}

extension Logger {
	@usableFromInline static let subsystem: String = Bundle.main.bundleIdentifier!

	@usableFromInline static let module: Logger = Logger(category: "UnityHubCommon")
}
