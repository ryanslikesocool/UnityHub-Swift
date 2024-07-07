import Foundation

public extension Shell {
	static let zsh: ShellType<ZSHArgument> = ShellType(executable: "/bin/zsh")
}

// MARK: - Argument

public enum ZSHArgument {
	case c
	case url(URL)
	case some(String)
}

// MARK: - ShellArgumentProtocol

extension ZSHArgument: ShellArgumentProtocol {
	public var shellArgument: String {
		switch self {
			case .c: "-c"
			case let .url(arg): arg.shellArgument
			case let .some(arg): arg
		}
	}
}

// MARK: - ExpressibleByStringLiteral

extension ZSHArgument: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self = .some(value)
	}
}
