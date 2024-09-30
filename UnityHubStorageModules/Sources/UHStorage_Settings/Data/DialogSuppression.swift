public struct DialogSuppression: OptionSet {
	public let rawValue: UInt8

	public init(rawValue: RawValue) {
		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension DialogSuppression: Sendable { }

// MARK: - Equatable

extension DialogSuppression: Equatable { }

// MARK: - Hashable

extension DialogSuppression: Hashable { }

// MARK: - Codable

extension DialogSuppression: Codable { }

// MARK: - Constants

public extension DialogSuppression {
	static let none: Self = Self(rawValue: 0)

	static let projectRemoval: Self = Self(rawValue: 1 << 0)
	static let installationRemoval: Self = Self(rawValue: 1 << 1)
}
