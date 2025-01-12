public enum ExecutableArchitecture: String {
	/// The 32-bit PowerPC architecture.
	case ppc

	/// The 64-bit PowerPC architecture.
	case ppc64

	/// The 32-bit Intel architecture.
	case i386

	/// The 64-bit Intel architecture.
	case x86_64

	/// The 64-bit ARM architecture.
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
