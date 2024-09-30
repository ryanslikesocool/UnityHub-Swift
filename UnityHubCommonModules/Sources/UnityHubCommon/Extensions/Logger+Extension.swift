import OSLog

public extension Logger {
	init(category: String) {
		self.init(subsystem: Self.subsystem, category: category)
	}

	@inlinable
	init(category: Any.Type) {
		self.init(category: String(describing: category))
	}
}

// MARK: - Module

extension Logger {
	@usableFromInline
	static let module: Logger = Logger(category: "UnityHubCommon")
}

// MARK: - Private

private extension Logger {
	static let subsystem: String = Bundle.main.bundleIdentifier!
}
