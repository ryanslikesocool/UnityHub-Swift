public extension UnityEditorVersion {
	enum Channel: String {
		case alpha = "a"
		case beta = "b"
		case release = "f"
		case patch = "p"
		case china = "c"

		public init?(rawValue: String) {
			guard let value = Self.allCases.first(where: { $0.rawValue == rawValue }) else {
				return nil
			}
			self = value
		}

		public init?(_ string: some StringProtocol) {
			self.init(rawValue: String(string))
		}
	}
}

// MARK: - Hashable

extension UnityEditorVersion.Channel: Hashable { }

// MARK: - Identifiable

extension UnityEditorVersion.Channel: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - CaseIterable

extension UnityEditorVersion.Channel: CaseIterable { }

// MARK: - Comparable

extension UnityEditorVersion.Channel: Comparable {
	public static func < (lhs: Self, rhs: Self) -> Bool {
		allCases.firstIndex(of: lhs) ?? 0 < allCases.firstIndex(of: rhs) ?? 0
	}
}

// MARK: - CustomStringConvertible

extension UnityEditorVersion.Channel: CustomStringConvertible {
	public var description: String { rawValue }
}

// MARK: - Constants

public extension UnityEditorVersion.Channel {
	/// Equivalent to ``UnityEditorVersion.Channel.release``.
	static let final: Self = .release

	/// Equivalent to ``UnityEditorVersion.Channel.alpha``.
	static let a: Self = .alpha

	/// Equivalent to ``UnityEditorVersion.Channel.beta``.
	static let b: Self = .beta

	/// Equivalent to ``UnityEditorVersion.Channel.release``.
	static let f: Self = .release

	/// Equivalent to ``UnityEditorVersion.Channel.patch``.
	static let p: Self = .patch

	/// Equivalent to ``UnityEditorVersion.Channel.china``.
	static let c: Self = .china
}
