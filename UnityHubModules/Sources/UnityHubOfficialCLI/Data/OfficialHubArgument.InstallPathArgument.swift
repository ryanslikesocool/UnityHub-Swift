import UnityHubShell

public extension OfficialHubArgument {
	@frozen
	struct InstallPathArgument: RawRepresentable {
		public typealias RawValue = String

		public let rawValue: RawValue

		public init(rawValue: RawValue) {
			self.rawValue = rawValue
		}
	}
}

// MARK: - Sendable

extension OfficialHubArgument.InstallPathArgument: Sendable { }

// MARK: - Equatable

extension OfficialHubArgument.InstallPathArgument: Equatable { }

// MARK: - Hashable

extension OfficialHubArgument.InstallPathArgument: Hashable { }

// MARK: - ShellArgumentProtocol

extension OfficialHubArgument.InstallPathArgument: ShellArgumentProtocol {
	public var shellArgument: String { rawValue }
}

// MARK: - Constants

public extension OfficialHubArgument.InstallPathArgument {
	static let get: Self = Self(rawValue: "--get")
	static let set: Self = Self(rawValue: "--set")
}