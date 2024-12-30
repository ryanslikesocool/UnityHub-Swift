public extension ProjectInfoVisibility {
	struct Mask: OptionSet {
		public typealias RawValue = ProjectInfoVisibility.RawValue

		public let rawValue: RawValue

		public init(rawValue: UInt8) {
			self.rawValue = rawValue
		}
	}
}

// MARK: - Sendable

extension ProjectInfoVisibility.Mask: Sendable { }

// MARK: - Equatable

extension ProjectInfoVisibility.Mask: Equatable { }

// MARK: - Hashable

extension ProjectInfoVisibility.Mask: Hashable { }

// MARK: - Codable

extension ProjectInfoVisibility.Mask: Codable { }

// MARK: - CaseIterable

extension ProjectInfoVisibility.Mask: CaseIterable {
	public static let allCases: [Self] = ProjectInfoVisibility.allCases.map(Self.init)
}

// MARK: - Convenience

public extension ProjectInfoVisibility.Mask {
	init(_ element: ProjectInfoVisibility) {
		self.init(rawValue: 1 << element.rawValue)
	}
}

// MARK: - Constants

public extension ProjectInfoVisibility.Mask {
	static let location: Self = Self(.location)
	static let lastOpened: Self = Self(.lastOpened)
	static let icon: Self = Self(.icon)
	static let editorVersion: Self = Self(.editorVersion)
	static let editorVersionBadge: Self = Self(.editorVersionBadge)

	static let all: Self = [.location, .lastOpened, .icon, .editorVersion, .editorVersionBadge]
}
