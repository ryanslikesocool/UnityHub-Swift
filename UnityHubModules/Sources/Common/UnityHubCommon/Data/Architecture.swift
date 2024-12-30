public enum Architecture: String {
	case x86_64
	case arm64
}

// MARK: - Sendable

extension Architecture: Sendable { }

// MARK: - Equatable

extension Architecture: Equatable { }

// MARK: - Hashable

extension Architecture: Hashable { }

// MARK: - Identifiable

extension Architecture: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Constants

public extension Architecture {
	static var current: Self {
#if !((os(macOS) || targetEnvironment(macCatalyst)) && arch(x86_64))
		.arm64
#else
		.x86_64
#endif
	}
}
