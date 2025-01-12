import Foundation

public struct ZSHArgument: RawRepresentable {
	public typealias RawValue = String

	public let rawValue: RawValue

	public init(rawValue: RawValue) {
		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension ZSHArgument: Sendable { }

// MARK: - ShellArgumentProtocol

extension ZSHArgument: ShellArgumentProtocol {
	public var shellArgument: String {
		rawValue
	}
}

// MARK: - ExpressibleByStringLiteral

extension ZSHArgument: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self.init(rawValue: value)
	}
}

// MARK: - Convenience

public extension ZSHArgument {
	init(_ rawValue: RawValue) {
		self.init(rawValue: rawValue)
	}
}

// MARK: - Constants

public extension ZSHArgument {
	static let c: Self = "-c"

	static func url(_ url: URL) -> Self {
		Self(url.shellArgument)
	}
}