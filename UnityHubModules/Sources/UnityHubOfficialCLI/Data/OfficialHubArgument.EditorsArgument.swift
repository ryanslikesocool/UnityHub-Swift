import UnityHubShell

public extension OfficialHubArgument {
	@frozen
	struct EditorsArgument: RawRepresentable {
		public typealias RawValue = String

		public let rawValue: RawValue

		public init(rawValue: RawValue) {
			self.rawValue = rawValue
		}
	}
}

// MARK: - Sendable

extension OfficialHubArgument.EditorsArgument: Sendable { }

// MARK: - Equatable

extension OfficialHubArgument.EditorsArgument: Equatable { }

// MARK: - Hashable

extension OfficialHubArgument.EditorsArgument: Hashable { }

// MARK: - ShellArgumentProtocol

extension OfficialHubArgument.EditorsArgument: ShellArgumentProtocol {
	public var shellArgument: String { rawValue }
}

// MARK: - Constants

public extension OfficialHubArgument.EditorsArgument {
	static let all: Self = Self(rawValue: "--all")
	static let releases: Self = Self(rawValue: "--releases")
	static let installed: Self = Self(rawValue: "--installed")
}