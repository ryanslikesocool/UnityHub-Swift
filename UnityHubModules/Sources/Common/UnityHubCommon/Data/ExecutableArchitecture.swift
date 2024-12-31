public enum ExecutableArchitecture: String {
	case x86_64
	case arm64
}

// MARK: - Sendable

extension ExecutableArchitecture: Sendable { }

// MARK: - Equatable

extension ExecutableArchitecture: Equatable { }

// MARK: - Hashable

extension ExecutableArchitecture: Hashable { }

// MARK: - Identifiable

extension ExecutableArchitecture: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Constants

public extension ExecutableArchitecture {
	static var current: Self {
#if !((os(macOS) || targetEnvironment(macCatalyst)) && arch(x86_64))
		.arm64
#else
		.x86_64
#endif
	}
}
