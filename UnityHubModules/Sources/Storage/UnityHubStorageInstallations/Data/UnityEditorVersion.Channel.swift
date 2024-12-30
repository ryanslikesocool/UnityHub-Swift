import OSLog

/// A Unity release channel.
public extension UnityEditorVersion {
	struct Channel: RawRepresentable {
		public typealias RawValue = String

		public let rawValue: RawValue

		public init(rawValue: String) {
			assert(rawValue.count == 1)
			self.rawValue = rawValue
		}

		public init?(_ string: some StringProtocol) {
			self.init(rawValue: String(string))
		}
	}
}

// MARK: - Sendable

extension UnityEditorVersion.Channel: Sendable { }

// MARK: - Equatable

extension UnityEditorVersion.Channel: Equatable { }

// MARK: - Hashable

extension UnityEditorVersion.Channel: Hashable { }

// MARK: - Identifiable

extension UnityEditorVersion.Channel: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - CaseIterable

extension UnityEditorVersion.Channel: CaseIterable {
	public static let allCases: [Self] = [
		.alpha, .beta, .release, .patch, .china,
	]
}

// MARK: - Comparable

extension UnityEditorVersion.Channel: Comparable {
	public static func < (lhs: Self, rhs: Self) -> Bool {
		(allCases.firstIndex(of: lhs) ?? Int.max) < (allCases.firstIndex(of: rhs) ?? Int.max)
	}
}

// MARK: - CustomStringConvertible

extension UnityEditorVersion.Channel: CustomStringConvertible {
	public var description: String { rawValue }
}

// MARK: - ExpressibleByStringLiteral

extension UnityEditorVersion.Channel: ExpressibleByStringLiteral {
	public init(stringLiteral value: RawValue.StringLiteralType) {
		self.init(rawValue: value)
	}
}

// MARK: - Constants

public extension UnityEditorVersion.Channel {
	/// Indicates the "alpha" release channel.
	static let alpha: Self = "a"

	/// Indicates the "beta" release channel.
	static let beta: Self = "b"

	/// Indicates the production-ready release channel.
	static let release: Self = "f"

	/// Indicates the "patch" release channel.
	static let patch: Self = "p"

	/// Indicates the release channel for versions of Unity released in China.
	static let china: Self = "c"

	/// Equivalent to ``UnityEditorVersion/Channel/alpha``.
	static let a: Self = .alpha

	/// Equivalent to ``UnityEditorVersion/Channel/beta``.
	static let b: Self = .beta

	/// Equivalent to ``UnityEditorVersion/Channel/release``.
	static let f: Self = .release

	/// Equivalent to ``UnityEditorVersion/Channel/patch``.
	static let p: Self = .patch

	/// Equivalent to ``UnityEditorVersion/Channel/china``.
	static let c: Self = .china
}
