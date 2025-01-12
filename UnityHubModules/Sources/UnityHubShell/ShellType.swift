import Foundation

public struct ShellType<Argument> where
	Argument: ShellArgumentProtocol
{
	public let executableURL: URL

	public init(executableURL: URL) {
		self.executableURL = executableURL
	}
}

// MARK: - Sendable

extension ShellType: Sendable { }

// MARK: - Equatable

extension ShellType: Equatable { }

// MARK: - Hashable

extension ShellType: Hashable { }

// MARK: - Identifiable

extension ShellType: Identifiable {
	public var id: URL { executableURL }
}

// MARK: - Convenience

public extension ShellType {
	init(executablePath: String) {
		self.init(
			executableURL: URL(filePath: executablePath, directoryHint: .notDirectory)
		)
	}
}

// MARK: - Constants

public extension ShellType where
	Argument == ZSHArgument
{
	static var zsh: Self {
		Self(executablePath: "/bin/zsh")
	}
}

// MARK: -

public extension ShellType {
	@discardableResult
	func callAsFunction(_ arguments: some Sequence<Argument>) throws -> String {
		try Shell.execute(
			executableURL,
			arguments: arguments.map(\.shellArgument)
		)
	}

	@discardableResult
	func callAsFunction(_ arguments: Argument...) throws -> String {
		try callAsFunction(arguments)
	}
}
