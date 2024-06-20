public extension InstallationInfoVisibility {
	struct Mask: OptionSet {
		public typealias RawValue = InstallationInfoVisibility.RawValue

		public let rawValue: RawValue

		public init(rawValue: UInt8) {
			self.rawValue = rawValue
		}

		public init(_ element: InstallationInfoVisibility) {
			self.init(rawValue: 1 << element.rawValue)
		}
	}
}

// MARK: - Hashable

extension InstallationInfoVisibility.Mask: Hashable { }

// MARK: - Codable

extension InstallationInfoVisibility.Mask: Codable { }

// MARK: - CaseIterable

extension InstallationInfoVisibility.Mask: CaseIterable {
	public static let allCases: [Self] = InstallationInfoVisibility.allCases.map(Self.init)
}

// MARK: - Constants

public extension InstallationInfoVisibility.Mask {
	static let location: Self = Self(.location)

	static let all: Self = [.location]
}
