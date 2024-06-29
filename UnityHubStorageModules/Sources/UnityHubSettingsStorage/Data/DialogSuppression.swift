public struct DialogSuppression: OptionSet {
	public let rawValue: UInt8

	public init(rawValue: UInt8) {
		self.rawValue = rawValue
	}
}

// MARK: - Hashable

extension DialogSuppression: Hashable { }

// MARK: - Codable

extension DialogSuppression: Codable { }

// MARK: - Constants

public extension DialogSuppression {
	static let none: Self = Self(rawValue: 0)

	static let projectRemoval: Self = Self(rawValue: 1 << 0)
	static let installationRemoval: Self = Self(rawValue: 1 << 1)
	static let invalidLocation: Self = Self(rawValue: 1 << 2)
}
